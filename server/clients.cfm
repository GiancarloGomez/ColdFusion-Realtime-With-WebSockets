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
	<cfloop array="#channels#" index="channel">
		<div>
			<h2>#channel# <sup class="badge">#subscribers[channel].len()#</sup></h2>
			<cfdump var="#subscribers[channel]#" />
		</div>
	</cfloop>
</cfoutput>