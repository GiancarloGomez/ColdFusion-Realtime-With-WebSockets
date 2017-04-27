component extends="CFIDE.websocket.ChannelListener" {

	public boolean function allowSubscribe(struct subscriberInfo){
		dashboardStream();
		return true;
	}

	public any function beforePublish( any message, struct publisherInfo){

		lock scope="application" timeout="10" type="exclusive"{
			application.publishedMessages++;
		}

		if (structKeyExists(arguments.publisherInfo,"username"))
			arguments.message = arguments.publisherInfo.username & " : " & arguments.message;

		dashboardStream();

		return arguments.message;
	}

	public function afterUnsubscribe(struct subscriberInfo){
		dashboardStream();
	}

	private function dashboardStream(){
		WsPublish("dashboard","go-fetch");
	}
}