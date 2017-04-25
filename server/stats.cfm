<cfscript>
	// get our stats
	channels 	= WSGetAllChannels();
	subscribers = {};
	stats 		= {
		channels 		: channels.len(),
		clients 		: [],
		messages 		: application.publishedMessages,
		subscriptions 	: 0,
		timestamp 		: application.timestamp
	};
	for (channel in channels){
		subscribers[channel] = WSgetSubscribers(channel,true);
		stats.subscriptions += subscribers[channel].len();
		for (sub in subscribers[channel]){
			if (!arrayFind(stats.clients,sub.clientid))
				stats.clients.append(sub.clientid);
		}
	};
	// set to count
	stats.clients = stats.clients.len();
	// output as json
	writeOutput(serializeJSON(stats));
</cfscript>