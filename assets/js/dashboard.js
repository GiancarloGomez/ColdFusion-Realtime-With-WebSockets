var chart,
    data,
    UI          = {},
    uiCharts    = {
    debug       : JSON.parse(document.body.dataset.debug || false),
    loadCharts  : false,
    fetchTo     : 0,
    options     : {
        areaOpacity : 0.1,
        animation   : {
            duration    : 300,
            easing      : 'inAndOut'
        },
        chartArea   : {left:0,top:'10%',width:'100%',height:'80%'},
        colors      : ['#31708f','#3c763d','#a94442'],
        fontName    : 'Lato',
        fontSize    : 12,
        hAxis       : {
            baselineColor   : 'none',
            textPosition    : 'none',
            gridlines       : {
                color : 'transparent'
            }
        },
        legend      : {
            position:'none'
        },
        lineWidth   : 4,
        pointSize   : 10,
        pointShape  : 'circle',
        vAxis       : {
            baselineColor : 'black',
            textPosition : 'in',
            gridlines       : {
                color : '#eee',
                count : 3
            },
            minValue : 1
        }
    },

    init : function (){
        uiCharts.log('init');
        data = new google.visualization.DataTable();
        data.addColumn('datetime', 'Time');
        data.addColumn('number', 'New Messages');
        data.addColumn('number', 'Clients');
        data.addColumn('number', 'Subscriptions');
        // setup the chart
        chart = new google.visualization.AreaChart(document.getElementById('lineChart'));
        // draw the chart
        if (uiCharts.loadCharts)
            uiCharts.draw();
    },

    draw : function(){
        uiCharts.log('draw');
        UI.livestats.removeClass('off');
        chart.draw(data, uiCharts.options);
    },

    addRow : function(d){
        // do not let the table be more than last 15 requests
        if (data.getNumberOfRows() >= 4){
            uiCharts.log('removeRow');
            data.removeRow(0);
        }
        uiCharts.log('addRow',d);
       // add row and render
        data.addRow(
            [moment().toDate(),d.newmessages,d.clients,d.subscriptions]
        );
        uiCharts.draw();
    },

    render : function(d){
        uiCharts.log('render',d);
        UI.timestamp.html('Since ' + moment(new Date(d.timestamp)).format('MM/DD/YYYY h:mm:ss a'));
        UI.messages.html(d.messages);
        UI.clients.html(d.clients);
        UI.subscriptions.html(d.subscriptions);
        uiCharts.addRow(d);
    },

    fetch : function(){
        uiCharts.log('fetch - request');
        if(uiCharts.loadCharts){
            // clear previous request if set
            window.clearTimeout(uiCharts.fetchTo);
            // get data
            $.ajax('/server/stats/',{
                dataType: 'json',
                error  : function(response){
                    uiCharts.log('fetch - error',response.statusText);
                    UI.notification.find('.modal-body').html('<div class="alert alert-danger text-center lead"><p><strong>Oh No! Something is wrong!!!</strong></p><p>The server states the following<br /><br /><strong>' + response.statusText + '</strong><br /><br /></p><p>Sorry for any inconvinience and please have a little patience with us as we try to resume communication.</p></div>').end().modal('show');
                    uiCharts.fetchTo = window.setTimeout(uiCharts.fetch,5000);
                },
                success : function(response){
                    uiCharts.log('fetch - complete');
                    UI.notification.modal('hide');
                    uiCharts.render(response);
                    // go and set to fetch again
                    uiCharts.fetchTo = window.setTimeout(uiCharts.fetch,5000);
                }
            });
        } else {
            uiCharts.log('fetch - did not run as stats are not up');
        }
    },

    log : function(){
        if (uiCharts.debug === true)
            console.log(Array.prototype.slice.call(arguments));
    }
};

// load Google Maps
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(uiCharts.init);

// load app
$(function(){

    UI = {
        broadcast       : $('#broadcast'),
        messages        : $('#mData'),
        clients         : $('#cData'),
        subscriptions   : $('#sData'),
        timestamp       : $('#timestamp'),
        livestats       : $('#live-stats'),
        livestatslink   : $('#live-stats-link'),
        notification    : $('#notification').modal({show:false,background:'static'})
    };

    UI.broadcast.on('click',function(e){
        $.post('/server/broadcast/');
        event.preventDefault();
    });

    UI.livestatslink.on('click',function(e){
        uiCharts.loadCharts = true;
        uiCharts.fetch();
        event.preventDefault();
    });

    uiCharts.fetch();

});