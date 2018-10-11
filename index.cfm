<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>Realtime w/ WebSockets</title>
	<link rel="icon" href="/favicon.ico">
	<link rel="author" href="/humans.txt" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/assets/css/theme.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
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

		<div class="alert alert-info text-center">
			<small>
				Console requires having the console code at the root of this site either
				by a virtual folder mapping or physical code in disk.
				<br /><br />
				If you use an alias make sure to change the following setting in the ColdFusion Administrator.
				<br /><span><strong>Application.cfc/Application.cfm lookup order<br />In webroot</strong></span>
			</small>
		</div>

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

	<p id="sig">
		Giancarlo Gomez<br />
		<a href="https://fusedevelopments.com" target="_blank">Fuse Developments</a> &bull;
		<a href="https://crosstrackr.com" target="_blank">CrossTrackr</a>
		<br />
		<a href="https://github.com/GiancarloGomez" target="_blank"><i class="fab fa-github"></i></a> &nbsp;
		<a href="https://twitter.com/GiancarloGomez" target="_blank"><i class="fab fa-twitter"></i></a> &nbsp;
		<a href="https://www.instagram.com/GiancarloGomez" target="_blank"><i class="fab fa-instagram"></i></a> &nbsp;
		<a href="https://www.facebook.com/giancarlo.gomez" target="_blank"><i class="fab fa-facebook"></i></a> &nbsp;
		<a href="https://www.linkedin.com/in/giancarlogomez" target="_blank"><i class="fab fa-linkedin-in"></i></a> &nbsp;
		<a href="https://www.giancarlogomez.com" target="_blank"><i class="fas fa-rss"></i></a> &nbsp;
		<a href="mailto:giancarlo.gomez@gmail.com"><i class="far fa-envelope"></i></a>
	</p>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/assets/js/moment.min.js"></script>
	<script src="/assets/js/dashboard.js"></script>

	<cfwebsocket 	name		= "ws"
					onMessage	= "onMessage"
					subscribeTo = "dashboard">
</body>
</html>