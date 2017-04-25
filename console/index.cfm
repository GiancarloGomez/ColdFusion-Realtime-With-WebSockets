<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title>WS : Console</title>
	<link rel="icon" href="favicon.png">
	<link rel="author" href="humans.txt" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato:300,400,700">
	<link rel="stylesheet" href="styles.css" />
</head>
<body>
	<div class="container-fluid top-20">

		<div class="well well-sm text-center">
			<button type="button" id="open" class="btn btn-success">Open Socket</button>
			<button type="button" id="stop" class="btn btn-danger">Stop Socket</button>
			<button type="button" id="check" class="btn btn-warning">Check Socket</button>
			<button type="button" id="getSubscribers" class="btn btn-info">Get Subscribers</button>
			<button type="button" id="getSubscriptions" class="btn btn-info">Get Subscriptions</button>
			<button type="button" id="clear" class="btn btn-default">Clear Log</button>
		</div>

		<div class="row">

			<div class="col-sm-6">
				<form name="f" class="form-horizontal" role="form">
					<div class="form-group">
						<label for="channelname" class="control-label col-sm-2">Channel</label>
						<div class="col-sm-10">
							<input id="channelname" name="channelname" class="form-control" type="text" value="" placeholder="websockets" list="channels" />
							<small class="help-block">Enter the channel name to subscribe to. Value is also used all functions below.</small>
						</div>
					</div>
					<div class="form-group">
						<label for="username" class="control-label col-sm-2">Username</label>
						<div class="col-sm-10">
							<input id="username" name="username" class="form-control" type="text" value="" placeholder="Enter a Username" />
							<small class="help-block">Use this if the channel you want to join requires it.</small>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10 col-sm-offset-2">
							<input id="subscribe" class="btn btn-primary" type="button" value="Subscribe" />
							<input id="unsubscribe" class="btn btn-danger" type="button" value="Unsubscribe" />
						</div>
					</div>
					<div class="form-group">
						<label for="msg" class="control-label col-sm-2">Message</label>
						<div class="col-sm-10">
							<textarea id="msg" class="form-control" placeholder="Enter Message" rows="8"></textarea>
							<br />
							<input id="publish" type="button" value="Publish" class="btn btn-success">
						</div>
					</div>
					<div class="form-group">
						<label for="msg" class="control-label col-sm-2">Component</label>
						<div class="col-sm-10">
							<input id="cfcname" class="form-control" name="cfcname" type="text" value="" placeholder="console.invokeandpublish" list="cfcs" />
							<small class="help-block">Enter the name of the CFC to invoke (dot syntax)</small>
						</div>
					</div>
					<div class="form-group">
						<label for="fnname" class="control-label col-sm-2">Function</label>
						<div class="col-sm-10">
							<input id="fnname" class="form-control" name="fnname" type="text" value="" placeholder="publish" list="functions" />
							<small class="help-block">Enter the name of the function to invoke</small>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10 col-sm-offset-2">
							<input id="invoke" type="button" value="Invoke" class="btn btn-success" />
							<input id="invokeAndPublish" type="button" value="Invoke And Publish" class="btn btn-primary"/>
						</div>
					</div>
				</form>
			</div>

			<div class="col-sm-6">
				<div class="well well-small" id="output">
					<ul id="_console" class="list-unstyled">
					</ul>
				</div>
			</div>

		</div>
	</div>
	<cfoutput>
	<datalist id="channels">
		<cfloop array="#WSGetAllChannels()#" index="channel">
			<option value="#channel#">
		</cfloop>
	</datalist>
	<datalist id="cfcs">
		<option value="console.invokeandpublish">
	</datalist>
	<datalist id="functions">
		<option value="publish">
		<option value="p2p">
	</datalist>
	</cfoutput>
	<script src="scripts.js"></script>

	<!--- Remember to remove the cgi.server_port_secure check if using proxy --->
	<cfwebsocket 	name="mywsobj"
					onMessage="messageHandler"
					onOpen="openHandler"
					onError="errorHandler"
					secure="#cgi.server_port_secure#" />
</body>
</html>