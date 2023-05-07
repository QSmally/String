
const std = @import("std");

const stdin = std.io
    .getStdIn()
    .reader();
const stdout = std.io
    .getStdOut()
    .writer();

var configuration = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = configuration.allocator();

pub fn main() !void {
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2)
        return help();

    const command = args[1];

    if (std.mem.eql(u8, command, "help"))     { help(); }
    else if (std.mem.eql(u8, command, "md5")) { try perform(@import("md5.zig"), args); }
    else if (std.mem.eql(u8, command, "e64")) { try perform(@import("e64.zig"), args); }
    else if (std.mem.eql(u8, command, "d64")) { try perform(@import("d64.zig"), args); }
    else std.debug.print("error: {s}: command not found\n", .{ command });
}

fn help() void {
    const message =
        \\ string - a tool to easily perform actions on strings.
        \\
        \\ USAGE
        \\  string <operation> <string>
        \\  source | string <operation>
        \\  source | string <operation> | destination
        \\
        \\OPERATIONS
        \\  md5: generate an md5 hash
        \\  e64: encode into a base-64 string
        \\  d64: decode from a base-64 string
    ;

    std.debug.print("{s}\n", .{ message });
}

fn perform(comptime command: anytype, args: [][]const u8) !void {
    if (args.len > 2) {
        const output = try command.perform(allocator, args[2]);
        try stdout.print("{s}\n", .{ output });
        return allocator.free(output);
    }

    while (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |batch| {
        const output = try command.perform(allocator, batch);
        try stdout.print("{s}\n", .{ output });
        allocator.free(batch);
        allocator.free(output);
    }
}
