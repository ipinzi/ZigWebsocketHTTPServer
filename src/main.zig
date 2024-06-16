const std = @import("std");
const util = @import("util.zig");
const websocket = @import("websocket.zig");
const httpServer = @import("http.zig");

// Define a struct for "global" data passed into your websocket handler
// This is whatever you want. You pass it to `listen` and the library will
// pass it back to your handler's `init`. For simple cases, this could be empty
const Context = struct {};

pub fn main() !void {
    const threadConfig = std.Thread.SpawnConfig{
        .stack_size = 1024 * 16,
    };

    util.print("", .{});
    util.printColor("==============================", .{}, "magenta");
    util.printColor("===== Ben's Pretty Logs! =====", .{}, "magenta");
    util.printColor("==============================", .{}, "magenta");

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    util.printColor("Current Working Directory is: {s}", .{
        try std.fs.cwd().realpathAlloc(allocator, "."),
    }, "cyan");
    util.print("", .{});

    const file = try util.readFile("src/home.html", allocator);
    defer allocator.free(file);
    util.printColor("{s}", .{file}, "cyan");

    const thread1 = try std.Thread.spawn(threadConfig, httpServer.httpServer, .{});
    const thread2 = try std.Thread.spawn(threadConfig, websocket.websocketServer, .{});

    thread1.join();
    thread2.join();
}
