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


    <script type="text/javascript" src="javascript/application.js"></script>
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
		
		#searchPanel {
			width: 740px;
			margin: auto;
			margin-top: 50px;
		}
		#requestPanel {
			width: 650px;
			margin: auto;
			margin-top: 25px;
		}
		.x-grid-view {
			overflow-x: hidden !important;
		}
		#spotifyButton {
			margin-top: 25px;
			text-align: center;
		}
		#urlPanel {
			text-align: center;
			margin: auto;
			margin-top: 50px;
			white-space: nowrap;
			font-size: 24px;
		}
		#urlPanel a {
			font-size: 24px;
		}
		#newPanel {
			text-align: center;
			margin: auto;
			margin-top: 50px;
			width: 800px;
			font-size: 24px;
		}
		#foot {
			text-align: center;
			margin: auto;
			margin-top: 25px;
			width: 800px;
			font-size: 18px;
		}
		#foot a{
			font-size: 16px;
		}
		#foot a:link{
			color: #4C7902;
		}
		#foot a:visited{
			color: #4C7902;
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
	
	<div id="newPanel"></div>
	
	<div id="searchPanel"></div>
	
	<div id="requestPanel"></div>
	
	<div id="spotifyButton"></div>
	
	<div id="urlPanel"></div>
	
	<div id="foot"><span><a href="javascript:void(0)" onclick="getRequests();">Check for New Additions</a> | <a href="http://peoplesplayli.st">Create a New List</a> | <a href="mailto:ahammond@wpi.edu?Subject=People's%20Playlist">Contact Us</a></span></div>
</body>
</html>
