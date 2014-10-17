/**
* @output false
*/
component{

    this.name              = "websockets";
    this.sessionmanagement = true;
    this.sessiontimeout    = createTimeSpan(1,0,0,0);

    // websockets
    this.wschannels = [
        {name:"demo",cfclistener:"listeners.ChannelListener"},
        {name:"websockets",cfclistener:"listeners.ChannelListener"},
        {name:"chat",cfclistener:"listeners.ChatListener"}
    ];

    // public void function onError(e){
    //     writeDump(e);
    // }

    public boolean function onApplicationStart(){
        application.timestamp                   = getHttpTimeString();
        application.publishedMessages           = 0;
        application.publishedPreviousMessages   = 0;
        return true;
    }

    public boolean function onRequestStart(targetPage){
        if (structKeyExists(url,"reload")){
            // tell everyone to reconnect
            for(local.key in WSGetAllChannels())
                WsPublish(local.key,"FORCE-RECONNECT");
            applicationStop();
            location('./',false);
        }
        return true;
    }

    public boolean function onWSAuthenticate(string username, string password, struct connectionInfo) {
        arguments.connectionInfo.authenticated = true;
        arguments.connectionInfo.username = arguments.username;
        return true;
    }

}