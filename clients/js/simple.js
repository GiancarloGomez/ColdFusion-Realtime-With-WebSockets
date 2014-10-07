var _console = document.getElementById('console');

document.getElementById('clearlog').addEventListener("click",function(e){
    e.preventDefault();
    _console.innerHTML = '';
})

function parseMessage(message){
    var t = new Date();
        t = t.toLocaleDateString() + ' ' + t.toLocaleTimeString();
    _console.innerHTML =    '<li><strong class="timestamp">' + t + '</strong>\n' +
                            '<pre>' +
                            JSON.stringify(message).replace(/,"/g,',\n "')
                                .replace('{','{\n ')
                                .replace('}','\n}') +
                            '</pre></li>' + _console.innerHTML;
}