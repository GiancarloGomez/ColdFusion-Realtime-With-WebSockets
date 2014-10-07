<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/favicon.png">
	<title>WS : Clients</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Lato:300,400,700">
	<link rel="stylesheet" href="/assets/css/theme.css">
</head>
<body>
	<cfscript>
		channels 	= WSGetAllChannels();
		clients 	= 0;
		subscribers = {};
		// sort my array for display
		arraySort(channels,"text");
		for (channel in channels){
			subscribers[channel] = WSgetSubscribers(channel);
			clients += subscribers[channel].len();
		}
	</cfscript>
	<cfoutput>
		<div class="container-fluid">
			<div class="page-header">
				<h1>Realtime with WebSockets <small>- #channels.len()# Channel#compare(channels.len(),1) ? "s" : ""# with #clients# Subscribed Client#compare(clients,1) ? "s" : ""#</small></h1>
			</div>
			<div class="row">
				<cfloop array="#channels#" index="channel">
					<div class="col-sm-#12/channels.len()#">
						<h2>#channel# <sup class="badge">#subscribers[channel].len()#</sup></h2>
						<cfdump var="#subscribers[channel]#" />
					</div>
				</cfloop>
			</div>
		</div>
	</cfoutput>

</body>
</html>