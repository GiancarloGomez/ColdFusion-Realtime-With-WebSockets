<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/favicon.png">
	<title>WS : Advanced Client</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<script src="/assets/js/lib/modernizr.min.js"></script>
	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Lato:300,400,700">
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
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

	<!-- Local Scripts -->
	<script src="/src/advancedsocket.js"></script>
	<script src="/assets/js/simple.js"></script>

	<cfwebsocket 	name		= "ws"
					onMessage	= "AdvancedSocket.onMessage"
					onOpen		= "AdvancedSocket.onOpen"
					onClose		= "AdvancedSocket.onClose"
					onError		= "AdvancedSocket.onError"
					secure  	= "#cgi.server_port_secure#">

	<script>
		function doMessage(obj){
			parseMessage(obj);
		}
	</script>
</body>
</html>