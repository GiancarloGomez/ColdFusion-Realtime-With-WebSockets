var UI = {};

function onMessage(message){
    if (message.data === 'go-fetch')
        UI.fetchStats();
}

// https://davidwalsh.name/javascript-debounce-function
function debounce(func, wait, immediate) {
    var timeout;
    return function() {
        var context = this, args = arguments;
        var later = function() {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};

// prepare notification
function prepareNotification(title,body){
    if (!('Notification' in window)){
        alert ('Message Sent');
    }
    else if (Notification.permission === 'granted'){
        sendNotification(title,body);
    }
    else if (Notification.permission !== 'denied'){
        Notification.requestPermission(function(permission){
            if (permission === 'granted')
                sendNotification(title,body);
        });
    }
}

// send notification
function sendNotification(title,body){
    var notification = new Notification(title,{
        body : body,
        icon : 'favicon.ico'
    });
    // close out notification automatically
    setTimeout(notification.close.bind(notification),5000);
}

// load app
$(function(){

    UI = {
        broadcast       : $('#broadcast'),
        subscribers     : $('#clients-link'),
        mdl             : $('#notification').modal({show:false,backdrop:'static'}),
        messages        : $('#mData'),
        clients         : $('#cData'),
        subscriptions   : $('#sData'),
        timestamp       : $('#timestamp'),
        livestats       : $('#live-stats'),
        livestatslink   : $('#live-stats-link'),
        notification    : $('#notification').modal({show:false,background:'static'}),
        statsOn         : false,
        fetchStats      : debounce(function() {
                                $.post('/server/stats.cfm')
                                        .done(function(response){
                                            if (UI.statsOn)
                                                UI.livestats.removeClass('off');
                                            response = JSON.parse(response);
                                            UI.messages.html(response.messages);
                                            UI.clients.html(response.clients);
                                            UI.subscriptions.html(response.subscriptions);
                                        });
                          }, 250)
    };

    // broadcast message
    UI.broadcast.on('click',function(e){
        $.post('/server/broadcast/')
            .done(function(response){
                prepareNotification(`BROADCAST`,response);
            });;
        e.preventDefault();
    });

    // show subscribers
    UI.subscribers.on('click',function(){
        var channel = this.dataset.channel;
        $.ajax('/server/clients/')
            .done(function(response){
                UI.mdl.modal('show')
                    .find('.modal-body').html(response);
            });
        return false;
    });

    UI.livestatslink.on('click',function(){
        if (UI.statsOn === false){
            UI.statsOn = true;
            UI.fetchStats();
        } else {
            UI.livestats.addClass('off');
            UI.statsOn = false;
        }
        return false;
    });
});