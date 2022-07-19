component {

    this.name              = "websockets";
    this.sessionmanagement = true;
    this.sessiontimeout    = createTimeSpan(1,0,0,0);
    this.serialization.preservecaseforstructkey = true;

    // websockets
    this.wschannels = [
        { name:"demo", cfclistener:"listeners.ChannelListener" },
        { name:"websockets", cfclistener:"listeners.ChannelListener" },
        { name:"chat", cfclistener:"listeners.ChatListener" },
        { name:"dashboard" }
    ];

    public boolean function onApplicationStart(){
        application.timestamp                   = getHttpTimeString();
        application.publishedMessages           = 0;
        application.publishedPreviousMessages   = 0;
        return true;
    }

    function onError(exception,eventName){
        writeDump(arguments.exception);
    }

    public boolean function onRequestStart(targetPage){
        if ( structKeyExists(url,"reload") ){
            // tell everyone to reconnect
            for( var key in wsGetAllChannels() )
                wsPublish(key,"FORCE-RECONNECT");
            applicationStop();
            location('./',false);
        }
        return true;
    }

    /**
    * Demo User Authentication - very simple
    * Here you would do real work
    */
    public boolean function onWSAuthenticate(string username, string password, struct connectionInfo) {
        var usersAllowed    = ["JC","Maria","Mailang","Jonah","Gia","Molly","Lilly"];
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