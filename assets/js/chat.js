var _users = document.getElementById('users');

function receiveMessage(obj){
    if(typeof obj.data === 'object'){
        // process connected user menu
        _users.innerHTML = obj.data.data;
    } else if (obj.data !== 'FORCE-RECONNECT') {
        _console.innerHTML += obj.data;
        // animate the scroll
        $(_console).animate({scrollTop : _console.scrollHeight + 'px'},500);
        // _console.scrollTop = _console.scrollHeight;
    }
}

$(function(){

    var m           = $('#login').modal({
                        backdrop    : 'static',
                        keyboard    : false
                    }),
        bd          = $('body'),
        u_name      = m.find('input'),
        u_parent    = u_name.parents('.form-group'),
        message     = $('#message'),
        sendMessage = $('#messageFrm'),
        leave       = $('#leave-room');

    // focus on login field
    m.on('shown.bs.modal',function(e){
        u_name.val('').focus();
        _console.innerHTML = '';
        _users.innerHTML = '';
    });

    // leave room
    leave.on('click',function(){
        // Unsibscribe
        ws.unsubscribe(AdvancedSocket.channels[0]);
        // change our AdvancedSocket to not run the Auto Connect feature
        AdvancedSocket.autoConnect = false;
        AdvancedSocket.checkConnection();
        // UI Updates
        bd.addClass('off');
        m.modal('show');
        return false;
    })

    // join room
    m.find('#loginFrm').submit(function(){
        var value = u_name.val().trim();
        if (value === ''){
            u_parent.addClass('has-error');
            u_parent.find('.help-block').html('Please enter a username to login');
        } else {
            // set the username into our Client Info
            AdvancedSocket.clientInfo.username = value;
            // Authenticate User
            ws.authenticate(value, '');
            // Welcome User
            _console.innerHTML += '<div class="message clear"><div class="content">Welcome to the chat room ' + value + '</div></div>';
            // UI Updates
            bd.removeClass('off');
            m.modal('hide');
            message.focus();
            leave.removeClass('hide');
        }
        return false;
    });

    // username blur
    u_name.on('focus',function(){
       u_parent.removeClass('has-error');
       u_parent.find('.help-block').html('');
    });

    // send message
    sendMessage.submit(function(){
        var value = message.val().trim();
        if (value !== ''){
            ws.publish(AdvancedSocket.channels[0],value);
        }
        message.val('').focus();
        return false;
    });

});