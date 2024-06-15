const std = @import("std");
const util = @import("util.zig");
const websocket = @import("websocket");

const Conn = websocket.Conn;
const Message = websocket.Message;
const Handshake = websocket.Handshake;

const Context = struct {};
pub fn websocketServer() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var context = Context{};
    util.print("Websocket server listening on Port: 9223...", .{});

    websocket.listen(WebsocketHandler, allocator, &context, .{
        .port = 9223,
        .max_headers = 10,
        .address = "127.0.0.1",
    }) catch |err| util.print("ERROR: {any}", .{err});
}

const WebsocketHandler = struct {
    conn: *Conn,
    context: *Context,

    pub fn init(h: Handshake, conn: *Conn, context: *Context) !WebsocketHandler {
        // `h` contains the initial websocket "handshake" request
        // It can be used to apply application-specific logic to verify / allow
        // the connection (e.g. valid url, query string parameters, or headers)

        _ = h; // we're not using this in our simple case

        util.print("[Websocket] Connected", .{});

        return WebsocketHandler{
            .conn = conn,
            .context = context,
        };
    }

    // optional hook that, if present, will be called after initialization is complete
    //pub fn afterInit(self: *Handler) !void {}

    pub fn handle(self: *WebsocketHandler, message: Message) !void {
        const data = message.data;
        util.print("[Websocket] Message: {s}", .{data});
        try self.conn.write(data); // echo the message back
    }

    // called whenever the connection is closed, can do some cleanup in here
    pub fn close(_: *WebsocketHandler) void {
        util.print("[Websocket] Connection Closed", .{});
    }
};
