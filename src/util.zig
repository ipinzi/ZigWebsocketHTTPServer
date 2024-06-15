const std = @import("std");

//TYPES
pub const String = []const u8;

//FUNCTIONS
pub fn print(comptime fmt: String, args: anytype) void {
    const writer = std.io.getStdOut().writer();
    nosuspend writer.print(fmt ++ "\n", args) catch return;
}
pub fn readFile(filepath: String) !String {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Open a file.
    const file = try std.fs.cwd().openFile(filepath, .{});
    defer file.close();

    // Read the file into a buffer.
    const stat = try file.stat();
    const buffer = try file.readToEndAlloc(allocator, stat.size);
    defer allocator.free(buffer);

    // Convert the result to a Zig string
    const zigString = buffer[0..];

    // Print the accumulated string
    std.debug.print("Accumulated result: {any}\n", .{zigString});

    return zigString;
}
