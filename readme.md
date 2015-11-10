#AdvancedSocket

AdvancedSockets aims to help handling connectivity issues from the client side when using ColdFusion WebSocket solution.

Below is a simple example of how to implement. The data attributes defined in the body are the default values and do not have to be set but can be overridden. For more information on how and where they are set refer to the Attributes / Properties section.

 ``` html
 	<body 	data-auto-connect="true"
 			data-name="ws"
 			data-channels="channelname"
 			data-debug="true"
 			data-do-message="doMessage"
 			data-online-timer="30"
 			data-offline-timer="5"
 			data-reconnect-timer=".5"
 			data-ping="ping.cfm">
 	<div id="status-message" class="hide"></div>
 	<script src="advanced.js"></script>
	<cfwebsocket 	name		="ws"
					onMessage	="AdvancedSocket.onMessage"
					onOpen		="AdvancedSocket.onOpen"
					onClose		="AdvancedSocket.onClose"
					onError		="AdvancedSocket.onError">
	<script>
		function doMessage(obj){
			console.log(obj);
		}
	</script>
	</body>
 ```

## Properties / Attributes

- __autoConnect__<br />
Controls the auto connect feature of the AdvancedSocket. It defaults to true but can be managed by the data-auto-connect attribute in the body tag. It also requires a pingURL to be defined.
- __name__<br />
The name of your global websocket variable name. Defaults to `ws`
- __channels__<br/ >
Comma separated list of channels to subscribe to.
- __clientID__<br />
The subscriber ID returned from ColdFusion on a succesful connection. This is used when the autoConnect feature is enabled to make sure that we are still an active subscriber.
- __clientInfo__<br />
This is a key-value object that is passed when creating a connection. By default AdvancedSocket uses a third party request to find out additional geo-based data of the request. This is also used to pass in a username and any additional info you may want to.
- __doMessage__<br />
Defines the global function to run on a succesful message. Defaults to `doMessage`. If the function is not defined or does not exists a log message will be displayed (if debug is enabled).
- __timer__<br />
Used for the check AdvancedSocket.checkConnection setTimeout
- __pingURL__<br />
The URL that will be used to ping if we are still a good connection. Should return a JSON object with a success value of true or false.
- __onlineTimer__<br />
The timeout value to ping if autoConnect is enabled while we have a good connection. This defaults to 30 seconds and can be defined in the body data-online-timer attribute.
- __offlineTimer__<br />
The timeout value to ping if autoConnect is enabled while we have a bad connection. This defaults to 5 seconds and can be defined in the body data-offline-timer attribute.
- __reconnectTimer__<br />
The timeout value call a reconnect attempt when a `FORCE-RECONNECT` value is received from the server. This defaults to 500ms and can be defined in the body data-reconnect-timer attribute.
- __timerCount__<br />
The timeout value that is used on reconnect calls. It is automally updated to either the online or offline value based on current state.
- __debug__<br />
Boolean value to display log messages. Defaults to false and can be overwritten by the data-debug body attribute.
- __statusLabel__<br />
The status document element defined by an id of status-message.

## Functions

- __init__<br />
Sets up all required EventListeners to handle window connection events (connectionerror, goodconnection, requireconnection, offline, online). Sets up the timerCount to the onlineCount and then request the checkConnection() function.
- __checkConnection__<br />
Sets up timer and request first ping() call if autoConnect is enabled.
- __fireEvent__<br />
Creates and dispatches custom events.
- __ping__<br />
Polls request to the server to check if connection is still valid.
- __onMessage__<br />
Handles messages returned. On `welcome, authenticate and/or subscribe` messages it auto fires the AdvancedSocket.connected() function. On `FORCE-RECONNECT` messages fires the AdvancedSocket.forceReconnect() funciton based on the reconnectCount. On a regular messages passes to the Global Function that will handle your message.
- __onOpen__<br />
Fired onced the connection is open. If authentication is required, it calls the authenticate() WS function if not passes to the AdvancedSocket.getIPInfo() function, which is the last step before subscribing.
- __onClose__<br />
Fired on connection close
- __onError__<br />
Fired on connection errors
- __getIPInfo__<br />
Makes a request to ip-api.com to request Geo Based IP data. On response or if jQuery is not available it will call AdvancedSocket.connectWS(), the final step which handles all connections.
- __connectWS__<br />
Loops thru your defined channels and calls the WS subscribe() function.
- __forceReconnect__<br />
Fired when a `FORCE-RECONNECT` message is received. Calls the WS closeConnection() and openConnection() functions which in turn when the socket is open again fires the AdvancedSocket.onOpen() function.
- __disconnected__<br />
Fired when a socket is disconnected. Updates the status label.
- __connected__<br />
Fired when the socket is connecting. Updates the status label.
- __log__<br />
Outputs console logs if debug is set to true. This can be defined with the body data-debug attribute.