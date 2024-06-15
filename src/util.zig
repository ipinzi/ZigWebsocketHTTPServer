const std = @import("std");

//TYPES
pub const String = []const u8;

//FUNCTIONS
pub fn print(comptime fmt: String, args: anytype) void {
    const writer = std.io.getStdOut().writer();
    nosuspend writer.print(fmt ++ "\n", args) catch return;
}
pub fn printColor(comptime fmt: String, args: anytype, comptime color: []const u8) void {
    const colorStr = comptime color_picker: {
        if (std.mem.eql(u8, color, "black")) {
            break :color_picker "\x1b[30m";
        } else if (std.mem.eql(u8, color, "blue")) {
            break :color_picker "\x1b[34m";
        } else if (std.mem.eql(u8, color, "b")) {
            break :color_picker "\x1b[1m";
        } else if (std.mem.eql(u8, color, "d")) {
            break :color_picker "\x1b[2m";
        } else if (std.mem.eql(u8, color, "cyan")) {
            break :color_picker "\x1b[36m";
        } else if (std.mem.eql(u8, color, "green")) {
            break :color_picker "\x1b[32m";
        } else if (std.mem.eql(u8, color, "magenta")) {
            break :color_picker "\x1b[35m";
        } else if (std.mem.eql(u8, color, "red")) {
            break :color_picker "\x1b[31m";
        } else if (std.mem.eql(u8, color, "white")) {
            break :color_picker "\x1b[37m";
        } else if (std.mem.eql(u8, color, "yellow")) {
            break :color_picker "\x1b[33m";
        } else if (std.mem.eql(u8, color, "r")) {
            break :color_picker "\x1b[0m";
        } else {
            @compileError("Invalid color name passed: " ++ color);
        }
    };
    print(colorStr ++ fmt ++ "\x1b[37m", args);
}
pub fn logError(comptime fmt: String, args: anytype) void {
    std.debug.print("\x1b[31m" ++ fmt ++ "\x1b[37m\n", args);
}
pub fn logWarning(comptime fmt: String, args: anytype) void {
    std.debug.print("\x1b[33m" ++ fmt ++ "\x1b[37m\n", args);
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
