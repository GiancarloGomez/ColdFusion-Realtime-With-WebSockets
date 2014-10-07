 var UI = {
        console     : document.getElementById("_console"),
        channelname : document.getElementById("channelname"),
        username    : document.getElementById("username"),
        message     : document.getElementById("msg"),
        cfcname     : document.getElementById("cfcname"),
        fnname      : document.getElementById("fnname"),
        buttons     : {
            subscribe           : document.getElementById("subscribe"),
            unsubscribe         : document.getElementById("unsubscribe"),
            getSubscribers      : document.getElementById("getSubscribers"),
            getSubscriptions    : document.getElementById("getSubscriptions"),
            publish             : document.getElementById("publish"),
            invoke              : document.getElementById("invoke"),
            invokeAndPublish    : document.getElementById("invokeAndPublish"),
            stop                : document.getElementById("stop"),
            open                : document.getElementById("open"),
            check               : document.getElementById("check"),
            clear               : document.getElementById("clear")
        }
};

// register click events for each button
UI.buttons.subscribe.addEventListener("click",subscribeMe);
UI.buttons.unsubscribe.addEventListener("click",unsubscribeMe);
UI.buttons.getSubscribers.addEventListener("click",getSubscribers);
UI.buttons.getSubscriptions.addEventListener("click",getSubscriptions);
UI.buttons.publish.addEventListener("click",publish);
UI.buttons.invoke.addEventListener("click",invoke);
UI.buttons.invokeAndPublish.addEventListener("click",invokeAndPublish);
UI.buttons.stop.addEventListener("click",stopSocket);
UI.buttons.stop.addEventListener("click",stopSocket);
UI.buttons.open.addEventListener("click",openSocket);
UI.buttons.check.addEventListener("click",checkSocket);
UI.buttons.clear.addEventListener("click",clearLog);

function parseJSONResponse(message){
    return JSON.stringify(message)
        .replace(/,"/g,',<br />&nbsp;&nbsp;"')
        .replace('{','{<br />&nbsp;&nbsp;')
        .replace('}','<br />}');
}

function writeToConsole(message,classname){
    UI.console.innerHTML = '<li class="' + (classname || 'default')+ '">' + message + '</li>' + UI.console.innerHTML;
}

function clearLog(e){
    UI.console.innerHTML = '';
    e.target.blur();
}

//messagehandler recieves all the messages from websocket
function messageHandler(messageobj) {
    writeToConsole(parseJSONResponse(messageobj), messageobj.type !== 'data' ? 'alert alert-info' : '');
}

//openhandler is invoked when socket connection is
function openHandler(){
    writeToConsole('OPEN HANDLER INVOKED','alert alert-success');
}

//openhandler is invoked when a socket error occurs
function errorHandler(messageobj) {
    writeToConsole(parseJSONResponse(messageobj),'alert alert-warning');
}

function subscribeMe(e){
    e.target.blur();
    if(checkSocketAccess()){
        if (UI.channelname.value === 'chat'){
            if (UI.username.value !== ''){
                mywsobj.authenticate(UI.username.value,'');
                mywsobj.subscribe(UI.channelname.value,{username:UI.username.value});
            } else {
                writeToConsole('Username required when attempting to connect to chat room','alert alert-warning');
            }
        } else {
            mywsobj.subscribe(UI.channelname.value);
        }

    }
}

function getSubscribers(e){
    e.target.blur();
    if(checkSocketAccess())
        mywsobj.getSubscriberCount(UI.channelname.value);
}

function unsubscribeMe(e){
    e.target.blur();
    if(checkSocketAccess())
        mywsobj.unsubscribe(UI.channelname.value);
}

function publish(e){
    e.target.blur();
    if(checkSocketAccess()){
        if (UI.message.value !== ''){
            mywsobj.publish(UI.channelname.value,UI.message.value);
            UI.message.value = '';
        } else {
            writeToConsole('Enter a message to publish','alert alert-danger');
        }
    }
}

function getSubscriptions(e){
    e.target.blur();
    if(checkSocketAccess())
        mywsobj.getSubscriptions();
}

function invokeAndPublish(e){
    e.target.blur();
    if(checkSocketAccess())
        mywsobj.invokeAndPublish(UI.channelname.value, UI.cfcname.value, UI.fnname.value);
}

function invoke(e){
    e.target.blur();
    if(checkSocketAccess())
        mywsobj.invoke(UI.cfcname.value, UI.fnname.value);
}

function openSocket(e){
    e.target.blur();
    writeToConsole('OPENING SOCKET','alert alert-success');
    mywsobj.openConnection();
}

function stopSocket(e){
    e.target.blur();
    writeToConsole('CLOSING SOCKET','alert alert-danger');
    mywsobj.closeConnection();
}

function checkSocket(e){
    e.target.blur();
    if (mywsobj.isConnectionOpen())
        writeToConsole('SOCKET IS OPEN','alert alert-success');
    else
        writeToConsole('SOCKET IS CLOSED','alert alert-danger');
}

function checkSocketAccess(){
    if (mywsobj.isConnected()){
        return true;
    } else {
        writeToConsole('SOCKET IS NOT CONNECTED - FUNCTION COULD NOT BE PROCESSED','alert alert-danger');
        return false;
    }
}