<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/favicon.png">
	<title>WS : Chat</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<script src="/assets/js/lib/modernizr.min.js"></script>
	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Lato:300,400,700">
	<link rel="stylesheet" href="/assets/css/theme.css">
	<link rel="stylesheet" href="/assets/css/styles.css">
	<link rel="stylesheet" href="/assets/css/chat.css">
</head>
<body data-channels="chat" data-debug="false" data-auto-connect="false" data-online-timer="10" data-ping-url="/clients/chat-ping/" data-do-message="receiveMessage" class="off">

	<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<span class="navbar-brand">Chat App</span>
			</div>
			<ul class="nav navbar-nav pull-right">
				<li><a href="#" id="clearlog">Clear Messages</a></li>
				<li><a href="#" id="leave-room" class="hide">Leave Room</a></li>
			</ul>
		</div>
	</nav>

	<div class="navbar navbar-default navbar-fixed-bottom">
		<div id="status-message" class="hide"></div>
	</div>

	<div class="navbar navbar-default navbar-fixed-bottom" id="chat-message-form">
		<form id="messageFrm">
		<div class="input-group">
			<input type="text" class="form-control" id="message">
			<span class="input-group-btn">
				<button class="btn btn-success" type="submit" id="send-message">Send</button>
			</span>
		</div>
		</form>
	</div>

	<div id="users"></div>

	<ul id="console" class="list-unstyled"></ul>

	<div class="modal fade" id="login">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Chat Login</h4>
				</div>
				<div class="modal-body">
					<form id="loginFrm">
					<div class="form-group">
						<label class="control-label" for="username">Name</label>
						<input type="username" class="form-control" id="username" placeholder="Enter your name">
						<span class="help-block"></span>
					</div>
					<div class="form-group" style="margin:0;">
						<button type="submit" class="btn btn-primary">Login</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<script src="/src/advancedsocket.js"></script>
	<script src="/assets/js/simple.js"></script>
	<script src="/assets/js/chat.js"></script>

	<cfwebsocket 	name		= "ws"
					onMessage	= "AdvancedSocket.onMessage"
					onOpen		= "AdvancedSocket.onOpen"
					onClose		= "AdvancedSocket.onClose"
					onError		= "AdvancedSocket.onError"
					secure 		= "#cgi.server_port_secure#">
</body>
</html>