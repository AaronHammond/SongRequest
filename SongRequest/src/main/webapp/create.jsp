<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
                      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>People's Playlist</title>

    <!-- ExtJS -->
    <link rel="stylesheet" type="text/css" href="http://dev.sencha.com/deploy/ext-4.1.0-gpl/resources/css/ext-all-gray.css" />
    <script type="text/javascript" src="http://dev.sencha.com/deploy/ext-4.1.0-gpl/ext-all.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	

    <!-- Example -->
    <script type="text/javascript">
		Ext.Loader.setConfig({enabled: true});
		
		Ext.onReady(function(){
			Ext.Ajax.defaultHeaders = {'Accept':'application/json'};
			button = Ext.create('Ext.Button', {
				margin: '5 10 0 10',
				text: '<span style="font-size: 36px;">Create My List</span>',
				padding: 10,
				renderTo: 'createPanel',
				handler: function() {
					Ext.Ajax.request({
						url: '/requestlists/create',
						method: 'POST',
						contentType: 'application/json',
						success: function(response){
							button.hide();
							var text = response.responseText;
							// process server response here
							//window.location = window.location + JSON.parse(text).token;
							jQuery('#linkPanel').html('<span>Share this link with your comrades: <a href="' + 'http://' + window.location.host + '/' + JSON.parse(text).token + '?new=yes">' + window.location.host + '/' + JSON.parse(text).token+ '</a></span>');
						}
					});
				}
			});
		});

	
	
	</script>
    <style type="text/css">
        .search-item {
            padding: 5px 10px;
            white-space: normal;
            color: #555;
            text-decoration: none;
            display: block;
            overflow: hidden;
        }

        .search-item h3 {
            display: block;
            font: inherit;
            font-weight: bold;
            color: #222;
        }

        .search-item h3 span {
            float: right;
            font-weight: normal;
            margin:0 0 5px 5px;
            width: 100px;
            clear: none;
        }

        html, body {
            border: 0;
			text-align: center;
        }
		
		#titlePane {
			margin: auto;
			width: 800px;
		}
		
		#createPanel {
			text-align: center;
			margin-top: 100px;
		}
		
		#linkPanel {
			text-align: center;
			margin: auto;
			white-space: nowrap;
			font-size: 36px;
		}
		#linkPanel a {
			font-size: 36px;
		}
		#infoPanel {
			text-align: center;
			margin: auto;
			margin-top: 25px;
			width: 700px;
			font-size: 20px;
		}
		#infoPanel a {
			font-size: 20px;
		}
    </style>
	
	<!--Google Analytics-->
	<script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-34338173-1']);
	  _gaq.push(['_trackPageview']);

	  (function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	  })();

	</script>
</head>
<body>

	<div id="titlePane">
		<img src="images/smallertitle.png" />
	</div>
	<div id="infoPanel">
	So. You're having a party and need song requests. Or maybe you just have a hole in your music library. Either way, you need an easy way for your friends to recommend music. That's where People's Playlist comes in. Click the button below to create a playlist. Anyone with the link can add songs, so share it. At any time, you can export your list to <a href="http://spotify.com/us" target="_blank">Spotify</a>. So what are you waiting for? Let the tunes flow.
	</div>
	
	<div id="createPanel"></div>
	
	<div id="linkPanel"></div>
</body>
</html>
