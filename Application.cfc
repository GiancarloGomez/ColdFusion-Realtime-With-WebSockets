component {

    this.name              = "websockets";
    this.sessionmanagement = true;
    this.sessiontimeout    = createTimeSpan(1,0,0,0);

    // websockets
    this.wschannels = [
        {name:"demo",cfclistener:"listeners.ChannelListener"},
        {name:"websockets",cfclistener:"listeners.ChannelListener"},
        {name:"chat",cfclistener:"listeners.ChatListener"},
        {name:"dashboard"}
    ];

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
        // IMPORTANT
        // If using proxy set this to false to avoid
        // "WebSocket server is not running in secure mode(SSL) Error"
        request.websockets_secure = cgi.server_port_secure;
        return true;
    }

    public boolean function onWSAuthenticate(string username, string password, struct connectionInfo) {
        // Demo User Authentication - very simple here you would do real work
        var usersAllowed    = ["JC","Bill","Susan"];
        var authenticated   = arrayFindNoCase(usersAllowed,arguments.username);
        if (authenticated){
            arguments.connectionInfo.authenticated = true;
            arguments.connectionInfo.username = arguments.username;
        } else {
            connectionInfo.authenticated = false;
        }
        return authenticated;
    }
}