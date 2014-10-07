/**
* @extends CFIDE.websocket.ChannelListener
*/
component {

	public boolean function allowSubscribe(struct subscriberInfo){
		return true;
	}

	public any function beforePublish( any message, struct publisherInfo){

		lock scope="application" timeout="10" type="exclusive"{
			application.publishedMessages++;
		}

		if (structKeyExists(arguments.publisherInfo,"username"))
			arguments.message = arguments.publisherInfo.username & " : " & arguments.message;
		return arguments.message;
	}

	public function afterUnsubscribe(struct subscriberInfo){
		for(local.key in WSGetAllChannels())
			WsPublish(local.key,arguments.subscriberInfo.connectioninfo.clientid & " UNSUBSCRIBED");
	}

}