component
{
	remote function publish()
	{
		return "This is the value returned from publish()";
	}
	remote function p2p()
	{
		thread name="backToInvoker_#createUUID()#" action="run"{
			for (i = 1; i <= 10; i++){
				sleep(1000);
				WSSendMessage(i & " of 10 : I am only returning this to the P2P Client");
			}
		}
		return "This is the value returned from p2p()";
	}
}