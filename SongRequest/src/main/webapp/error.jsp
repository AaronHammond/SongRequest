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
			margin-bottom: 50px;
		}
		
		#errorPanel {
			text-align: center;
			margin: auto;
			width: 800px;
			font-size: 36px;
		}
    </style>
</head>
<body>

	<div id="titlePane">
		<img src="images/smallertitle.png" />
	</div>
	
	<div id="errorPanel"> <img src="images/error.png" /><br/>
	<h1>Woops</h1>
	You managed to catch us with our pants down. Please shoot off an email to ahammond@wpi.edu and describe the issue.
	<br/><a href="/">Get Song Requests</a></div>
</body>
</html>
