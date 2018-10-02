<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>WS : Chat</title>
	<link rel="icon" href="/favicon.ico">
	<link rel="author" href="/humans.txt" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
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



	<!-- Third Party -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- Local Scripts -->
	<script src="/assets/js/advancedsocket.js"></script>
	<script src="/assets/js/simple.js"></script>
	<script src="/assets/js/chat.js"></script>

	<cfwebsocket 	name		= "ws"
					onMessage	= "AdvancedSocket.onMessage"
					onOpen		= "AdvancedSocket.onOpen"
					onClose		= "AdvancedSocket.onClose"
					onError		= "AdvancedSocket.onError">
</body>
</html>