<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>WS : Advanced Client</title>
	<link rel="icon" href="/favicon.ico">
	<link rel="author" href="/humans.txt" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
	<link rel="stylesheet" href="/assets/css/theme.css">
	<link rel="stylesheet" href="/assets/css/styles.css">
</head>
<body data-channels="demo,websockets" data-debug="true" data-online-timer="30" data-ping-url="/clients/ping/">

	<!-- Header -->
	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<span class="navbar-brand">Advanced Client</span>
			</div>
			<ul class="nav navbar-nav pull-right">
				<li><a href="#" id="clearlog">Clear Log</a></li>
			</ul>
		</div>
	</nav>

	<!-- Footer -->
	<div class="navbar navbar-default navbar-fixed-bottom">
		<div id="status-message" class="hide"></div>
	</div>

	<!-- Console -->
	<ul id="console" class="list-unstyled"></ul>

	<!-- Third Party -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- Local Scripts -->
	<script src="/assets/js/advancedsocket.js"></script>
	<script src="/assets/js/simple.js"></script>

	<cfwebsocket 	name		= "ws"
					onMessage	= "AdvancedSocket.onMessage"
					onOpen		= "AdvancedSocket.onOpen"
					onClose		= "AdvancedSocket.onClose"
					onError		= "AdvancedSocket.onError"
					secure  	= "#request.websockets_secure#">

	<script>
		function doMessage(obj){
			parseMessage(obj);
		}
	</script>
</body>
</html>