
const std = @import("std");

const usage = [_][]const u8 {
    "string - a tool to easily perform actions on strings.\n",
    "USAGE",
    "  string <operation> <string>",
    "  source | string <operation>",
    "  source | string <operation> | destination\n",
    "OPERATIONS",
    "  md5: generate an md5 hash",
    "  e64: encode into a base-64 string",
    "  d64: decode from a base-64 string" };

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
    else if (std.mem.eql(u8, command, "md5")) { try perform(@import("md5.zig").perform); }
    else if (std.mem.eql(u8, command, "e64")) { try perform(@import("e64.zig").perform); }
    else if (std.mem.eql(u8, command, "d64")) { try perform(@import("d64.zig").perform); }
    else std.debug.print("error: {s}: command not found\n", .{ command });
}

fn help() void {
    for (usage) |line| std.debug.print("{s}\n", .{ line });
}

fn perform(comptime command: fn (std.mem.Allocator, []const u8) anyerror![]u8) !void {
    while (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |batch| {
        const output = try command(allocator, batch);
        try stdout.print("{s}\n", .{ output });
        allocator.free(batch);
        allocator.free(output);
    }
}
