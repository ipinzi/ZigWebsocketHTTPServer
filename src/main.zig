const std = @import("std");
const util = @import("util.zig");
const websocket = @import("websocket.zig");
const httpServer = @import("http.zig");

pub fn main() !void {
    const threadConfig = std.Thread.SpawnConfig{
        .stack_size = 1024 * 16,
    };

    util.print("", .{});
    util.printColor("===============================", .{}, "magenta");
    util.printColor("==== Ipinzi's Pretty Logs! ====", .{}, "magenta");
    util.printColor("===============================", .{}, "magenta");

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    util.printColor("Current Working Directory is: {s}", .{
        try std.fs.cwd().realpathAlloc(allocator, "."),
    }, "cyan");
    util.print("", .{});

    const thread1 = try std.Thread.spawn(threadConfig, httpServer.httpServer, .{});
    const thread2 = try std.Thread.spawn(threadConfig, websocket.websocketServer, .{});

    thread1.join();
    thread2.join();
}
