const std = @import("std");
const util = @import("util.zig");
const httpz = @import("httpz");

const homeHtml: []const u8 = @embedFile("home.html");

pub fn httpServer() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var server = try httpz.Server().init(allocator, .{ .port = 4000 });
    defer server.deinit();

    // use get/post/put/head/patch/options/delete
    // you can also use "all" to attach to all methods
    const router = server.router();

    // overwrite the default notFound handler
    server.notFound(notFound);

    // overwrite the default error handler
    server.errorHandler(errorHandler);

    router.get("/", handleHome);
    router.get("/about", handleAbout);
    //router.get("/ws", handleWebsocket);

    util.print("Arrogant Zig Server Listening On Port: {any}", .{server.config.port});

    server.listen() catch |err| util.print("ERROR: {any}", .{err});
}
fn handleHome(req: *httpz.Request, res: *httpz.Response) anyerror!void {
    util.print("Request Body: {any}", .{req.body()});
    //const fileStr = try readFile("home.html");
    //print("file: {any}", .{fileStr});
    //print("HTML: {s}", .{homeHtml});
    res.body = homeHtml;
}

fn handleAbout(req: *httpz.Request, response: *httpz.Response) anyerror!void {
    const body = req.body();
    util.print("Request Body: {any}", .{body});
    response.body = "This is the about page.";
}
fn notFound(_: *httpz.Request, res: *httpz.Response) !void {
    res.status = 404;

    // you can set the body directly to a []u8, but note that the memory
    // must be valid beyond your handler. Use the res.arena if you need to allocate
    // memory for the body.
    res.body = "Not Found";
}

// note that the error handler return `void` and not `!void`
fn errorHandler(req: *httpz.Request, res: *httpz.Response, err: anyerror) void {
    res.status = 500;
    res.body = "Internal Server Error";
    std.log.warn("httpz: unhandled exception for request: {s}\nErr: {}", .{ req.url.raw, err });
}
