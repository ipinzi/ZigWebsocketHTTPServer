const std = @import("std");

//TYPES
///A compile time string ([]const u8)
pub const String = []const u8;
///A dynamic string ([]u8)
pub const DString = []u8;

//FUNCTIONS
pub fn print(comptime fmt: String, args: anytype) void {
    const writer = std.io.getStdOut().writer();
    nosuspend writer.print(fmt ++ "\n", args) catch return;
}
///Prints a colored log
///
/// ```util.printColor("A log entry: {s}", .{myStringVariable}, "cyan");```
///
/// Colors: ```black, blue, cyan, green, magenta, red, white, yellow```
pub fn printColor(comptime fmt: String, args: anytype, comptime color: String) void {
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

///Reads an entire file and outputs a mem allocated string
///
/// ```const file = try util.readFile("src/home.html", allocator);```
///
/// ```defer allocator.free(file);```
pub fn readFile(filepath: String, allocator: std.mem.Allocator) !DString {
    // Open a file.
    const file = std.fs.cwd().openFile(filepath, .{}) catch |err| {
        logError("File not found! {any}", .{err});
        return err;
    };
    defer file.close();

    // Read the file into a buffer.
    const stat = try file.stat();
    const buffer = try file.readToEndAlloc(allocator, stat.size);

    // Convert the result to a Zig string
    const fileAsString = buffer[0..];

    return fileAsString;
}
