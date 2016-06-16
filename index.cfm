<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>CF Summit 2014 - Real Time w/ WebsSockets</title>
	<link rel="icon" href="/favicon.png">
	<link rel="author" href="/humans.txt" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
	<link rel="stylesheet" href="/assets/css/theme.css">
</head>
<body data-debug="false">

	<div class="container-fluid">

		<div class="page-header">
			<h1>Realtime with WebSockets</h1>
		</div>

		<nav class="navbar navbar-default">
			<ul class="nav navbar-nav">
				<li><a href="/console/" target="blank">Console</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Client Apps<span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
            			<li><a href="/clients/01-simple/" target="_blank">Simple Example</a></li>
            			<li><a href="/clients/02-advanced/" target="_blank">Advanced Example</a></li>
            			<li><a href="/clients/03-chat/" target="_blank">Chat App</a></li>
            		</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Server <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
            			<li><a href="#" id="broadcast">Broadcast Message</a></li>
            			<li><a href="/server/clients/" target="_blank">Client List</a></li>
            		</ul>
				</li>
				<li><a href="#" id="live-stats-link">Live Stats</a></li>
				<li><a href="/?reload=1">Re-init Application</a></li>
			</ul>
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
					<div class="alert alert-info text-center large-data"><span id="mData"></span></div>
				</div>
				<div class="col-sm-4">
					<h4>Clients</h4>
					<div class="alert alert-success text-center large-data"><span id="cData"></span></div>
				</div>
				<div class="col-sm-4">
					<h4>Subscriptions</h4>
					<div class="alert alert-danger text-center large-data"><span id="sData"></span></div>
				</div>
			</div>

			<h4>Live Stats</h4>
			<div id="lineChart"></div>
		</section>

		<div class="modal fade" id="notification">
			<div class="modal-dialog">
				<div class="modal-body"></div>
			</div>
		</div>

	</div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="//www.google.com/jsapi"></script>
	<script src="/assets/js/moment.min.js"></script>
	<script src="/assets/js/dashboard.js"></script>
</body>
</html>