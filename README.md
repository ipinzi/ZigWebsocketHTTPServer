# Arrogant Pixel's Zig HTTP/Websocket Server

The server uses karlsequin's http and websocket library. You can find more info for them here: https://github.com/karlseguin/http.zig and here: https://github.com/karlseguin/websocket.zig.

This is a very basic HTTP and Websocket server system. HTTPZ takes care of all routing. Some useful filesystem helpers like ```readFile()``` make it easy to read html files dynamically and there is an example of a comptime embedded html file in http.zig

### Instructions

Simply clone the project onto your local machine:

```git clone https://github.com/ipinzi/ZigWebsocketHTTPServer.git```

You can then build and run the Zig project like so:

```zig build run```