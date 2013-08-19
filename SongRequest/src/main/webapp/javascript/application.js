var stores;
var grids;
var msgCt;

Ext.Loader.setConfig({enabled: true});
Ext.require([
    'Ext.data.*',
    'Ext.form.*',
	'Ext.Ajax.*',
	'Ext.proxy.*',
	'Ext.window.MessageBox'
]);

Ext.onReady(function(){
	//it's a new list! woo!
	if(getUrlVars()["new"] == 'yes'){
		Ext.get('newPanel').setHTML('<span>Congratulations! You\'re on your way to a new playlist! Anyone with the link to your list can add new songs. So go ahead, share the link below. You know you want to. </span>');
	}
	else{
		Ext.get('newPanel').setHTML('<span>Welcome! Add songs to this playlist by searching for them below.</span>');
	}
	
	Ext.get('urlPanel').setHTML('<span>Share this link with your comrades: <a href="http://' + window.location.host+window.location.pathname+ '">' + window.location.host+window.location.pathname + '</a></span>');
	stores = {
		searchTracks	: null,
		requestedTracks	: null
	};
	
    Ext.define("Track", {
        extend: 'Ext.data.Model',
        fields: [
            {name: 'name', type: 'string'},
            {name: 'artists', type: 'string'},
			{name: 'album'},
			{name: 'popularity', type: 'string'},
			{name: 'uri', type: 'string'}
        ]
    });


    stores.searchTracks = Ext.create('Ext.data.Store', {
        model: 'Track',
     });
	 
	stores.requestedTracks = Ext.create('Ext.data.Store', {
		model: 'Track',
	});
	
	getRequests();
    panel = Ext.create('Ext.panel.Panel', {
        title: 'Search Spotify',
        width: 400,
        bodyPadding: 10,
		flex: 1,
        layout: 'anchor',
        items: [{
            xtype: 'combo',
			id: 'cmbSong',
            store: stores.searchTracks,
            typeAhead: true,
            hideLabel: true,
            hideTrigger:true,
			autoSelect: true,
            anchor: '100%',
			queryParam: 'q',
			lastQuery: '',
			listeners: {
				'beforequery': getTracks
			},
			// Template for the dropdown menu.
			// Note the use of "x-boundlist-item" class,
			// this is required to make the items selectable.
			tpl: Ext.create('Ext.XTemplate',
				'<tpl for=".">',
					'<div class="x-boundlist-item">"{name}" by {artists} ({album.name} - {album.released})</div>',
				'</tpl>'
			),
			// template for the content inside text field
			displayTpl: Ext.create('Ext.XTemplate',
				'<tpl for=".">',
					'"{name}" by {artists} ({album.name} - {album.released})',
				'</tpl>'
			)
        }]
    });
	
	button = Ext.create('Ext.Button', {
		margin: '5 10 0 10',
		text: '<span style="font-size: 36px;">Add Song</span>',
        padding: 10,
		handler: function() {
			submitRequest(Ext.getCmp('cmbSong').valueModels);
		}
	});
	Ext.create('Ext.Panel', {
		layout: {
			type: 'hbox'
		},
		width: 750,
		border: false,
		renderTo: 'searchPanel',
		items: [panel, 
		button]
	});
	
	var grid = Ext.create('Ext.grid.Panel', {
		title: 'Added Songs',
		store: stores.requestedTracks,
		overflowX: 'hidden',
		emptyText: 'Oh no! No tracks have been added! Search for songs above to remedy this.',
		columns: [
			{
				text: 'Name',
				dataIndex: 'name',
				sortable: false,
				hideable: false,
				flex: 3
			},
			{
				text: 'Artist',
				dataIndex: 'artists',
				sortable: false,
				hideable: false,
				flex: 3
			},
			{
				text: 'Album',
				dataIndex: 'album',
				sortable: false,
				hideable: false,
				flex: 3,
				renderer: function(value) {
					return value.name;
				}
			},
			{
				text: 'Year',
				dataIndex: 'album',
				sortable: false,
				hideable: false,
				flex: 1,
				renderer: function(value) {
					return value.released;
				}
			}
		],
		height: 350,
		width: 650,
		renderTo: 'requestPanel'
	});
	button = Ext.create('Ext.Button', {
		margin: '5 10 0 10',
		text: '<span style="font-size: 36px;">Launch Spotify</span>',
        padding: 10,
		handler: createSpotifyModal,
		renderTo: 'spotifyButton'
	});
	grid.getView().refresh();
	
});
function getTracks(query, options){
	stores.searchTracks.removeAll();
	console.log('starting the process');
	Ext.Ajax.request({
		url: '/spotify/search/track',
		method: 'GET',
		params: {
			q: escape(query.query)
		},
		success: function(response){
			var text = response.responseText;
			// process server response here
			var trax = JSON.parse(text).tracks;
			
			for(var trak in trax){
				stores.searchTracks.add(createTrackFromSpotify(trax[trak]));
			}
			Ext.getCmp('cmbSong').collapse();
			Ext.getCmp('cmbSong').bindStore(stores.searchTracks);
			Ext.getCmp('cmbSong').expand();
		}
	});
	return false;
}
function getArtistString (artists) {
	var artistString;
	artistString = artists[0].name;
	if(artists.length != 1){
		for(var artist in artists){
			artistString.concat('& ' + artists[artist].name);
		}
	}
	return artistString;
}
function submitRequest (tracks){
	if(tracks && tracks.length == 1 && stores.requestedTracks.find('uri', tracks[0].data.uri) == -1 && stores.requestedTracks.findBy(checkNameDupes) == -1){
		request = {
			'spotifyURI': tracks[0].data.uri
			};
			
		Ext.Ajax.request({
			url: '/songrequests',
			method: 'POST',
			dataType: 'json',
			contentType: 'application/json',
			jsonData: JSON.stringify(request),
			params: {
				token: document.location.pathname.replace('/', '') 
			},
			success: function(response){
				stores.requestedTracks.add(tracks[0]);
				Ext.getCmp('cmbSong').clearValue();
			}
		});
	}
	else if(tracks && tracks.length == 1){
		Ext.MessageBox.alert('Couldn\'t Add Song','That track has already been added to the list!');
	}
	else {
		Ext.MessageBox.alert('Couldn\'t Add Song','That track doesn\'t appear to be on Spotify. Woops!');
	}
}
function getRequests(){
	stores.requestedTracks.removeAll();
	Ext.Ajax.request({
		url: '/requestlists/' + document.location.pathname.replace('/', ''),
		method: 'GET',
		contentType: 'application/json',
		success: function(response){
			json = JSON.parse(response.responseText);
			for(var track in json.data){
				addTrackByUri(json.data[track].spotifyURI);
			}
		}
	});
}
function addTrackByUri(uri){
	Ext.Ajax.request({
		url: '/spotify/lookup/uri',
		method: 'GET',
		params: {
			uri: escape(uri)
		},
		success: function(response){
			console.log('track');
			stores.requestedTracks.add(createTrackFromSpotify(JSON.parse(response.responseText).track));
		}
	});
}
function createTrackFromSpotify(track){
	return Ext.create('Track', {
					name: track.name,
					artists: getArtistString(track.artists),
					album: track.album,
					popularity: track.popularity,
					uri: track.href.replace('spotify:track:', '')
				});
}
function createSpotifyModal(){
	
	
	Ext.create('Ext.window.Window', {
		modal: true,
		html: '<iframe src="https://embed.spotify.com/?uri=spotify:trackset:PREFEREDTITLE:'+getURIChain()+'&theme=white" frameborder="0" allowtransparency="true" width="400" height="480"></iframe>',
		renderTo: document.body,
		resizable: false
	}).show();
	
}

function getURIChain(){
	var uriChain = '';
	for(track in stores.requestedTracks.data.items){
		uriChain = uriChain.concat(stores.requestedTracks.data.items[track].data.uri);
		if(track != (stores.requestedTracks.data.items.length-1))
		uriChain = uriChain.concat(',');
	}
	return uriChain;
}
function checkNameDupes(record, id){
	var selectedTrack = Ext.getCmp('cmbSong').valueModels[0].data;
	//i.e. if the name can be considered a dupe
	/*if(selectedTrack.name.indexOf(record.name) != -1 || record.name.indexOf(selectedTrack.name) =! -1){
		return true;
	}*/
	return (selectedTrack.name.toLowerCase() == record.data.name.toLowerCase());

}
function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

