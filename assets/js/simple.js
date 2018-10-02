// get our console and see if we are using firefox
var _console    = document.getElementById('console'),
    _scroll     = navigator.userAgent.indexOf('Firefox') !== -1;

// clear our log
document.getElementById('clearlog').addEventListener("click",function(e){
    e.preventDefault();
    _console.innerHTML = '';
})

function parseMessage(message){
    var _date   = new Date(),
        // format timestamp to a readable format
        _ts     = _date.toLocaleDateString() + ' ' + _date.toLocaleTimeString(),
        // format message object into multiline readable string
        _data   = JSON.stringify(message).replace(/,"/g,',\n "').replace('{','{\n ').replace('}','\n}'),
        // create new element
        _li     = document.createElement('li');
    // set the text
    _li.innerHTML = `<strong class="timestamp">${_ts}</strong><pre>${_data}</pre>`;
    // append element to console
    _console.appendChild(_li);

    // extra
    if (document.body.scrollIntoView)
        document.body.scrollIntoView({block: "end", behavior: "smooth"});
}
