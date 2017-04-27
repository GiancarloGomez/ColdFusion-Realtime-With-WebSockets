<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>Realtime w/ WebSockets</title>
	<link rel="icon" href="/favicon.ico">
	<link rel="author" href="/humans.txt" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
	<link rel="stylesheet" href="/assets/css/theme.css">
</head>
<body data-debug="false">

	<div class="container-fluid">

		<div class="page-header">
			<h1>Realtime with WebSockets</h1>
		</div>

		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<ul class="nav navbar-nav">
					<!--- Console moved to its own Repo which you can pull and include here --->
					<cfif directoryExists(expandPath("./console"))>
						<li><a href="/console/" target="blank">CONSOLE</a></li>
					</cfif>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">APPS <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="/clients/01-simple/" target="_blank">Simple Example</a></li>
							<li><a href="/clients/02-advanced/" target="_blank">Advanced Example</a></li>
							<li><a href="/clients/03-chat/" target="_blank">Chat App</a></li>
						</ul>
					</li>
					<li><a href="#" id="broadcast">BROADCAST</a></li>
					<li><a href="#" id="clients-link">CLIENTS</a></li>
					<li><a href="#" id="live-stats-link">STATS</a></li>
					<li><a href="/?reload=1">RE-INIT</a></li>
				</ul>
			</div>
		</nav>

		<section id="live-stats" class="off">
			<div class="page-header text-center">
				<h2>
					Stats
					<small id="timestamp"></small>
				</h2>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<h4>Published Messages</h4>
					<div class="alert alert-info text-center large-data"><span id="mData">0</span></div>
				</div>
				<div class="col-sm-4">
					<h4>Clients</h4>
					<div class="alert alert-success text-center large-data"><span id="cData">0</span></div>
				</div>
				<div class="col-sm-4">
					<h4>Subscriptions</h4>
					<div class="alert alert-danger text-center large-data"><span id="sData">0</span></div>
				</div>
			</div>
		</section>

	</div>

	<div class="modal fade" tabindex="-1" role="dialog" id="notification">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title">CLIENTS</h4>
				</div>
				<div class="modal-body"></div>
			</div>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/assets/js/moment.min.js"></script>
	<script src="/assets/js/dashboard.js"></script>

	<cfwebsocket 	name		= "ws"
					onMessage	= "onMessage"
					subscribeTo = "dashboard"
					secure  	= "#request.websockets_secure#">
</body>
</html>