<cfscript>
	// get our stats
	channels 	= WSGetAllChannels();
	subscribers = {};
	stats 		= {
		channels 		: channels.len(),
		clients 		: [],
		messages 		: application.publishedMessages,
		subscriptions 	: 0,
		timestamp 		: application.timestamp,
		newmessages		: application.publishedMessages - application.publishedPreviousMessages
	};
	for (channel in channels){
		subscribers[channel] = WSgetSubscribers(channel,true);
		stats.subscriptions += subscribers[channel].len();
		for (sub in subscribers[channel]){
			if (!arrayFind(stats.clients,sub.clientid))
				stats.clients.append(sub.clientid);
		}
	};

	// updated application.publishedPreviousMessages
	lock scope="application" timeout="10" type="exclusive"{
		application.publishedPreviousMessages = application.publishedMessages;
	}

	stats.clients = stats.clients.len();
	writeOutput(serializeJSON(stats));
</cfscript>