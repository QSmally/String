
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
var configuration = std.heap.GeneralPurposeAllocator(.{}){};

pub fn main() !void {
    const allocator = configuration.allocator();
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2)
        return help();

    const command = args[1];

    if (std.mem.eql(u8, command, "help"))     { help(); }
    else if (std.mem.eql(u8, command, "md5")) { try @import("md5.zig").command(allocator); }
    else if (std.mem.eql(u8, command, "e64")) { std.debug.print("TODO: e64\n", .{}); }
    else if (std.mem.eql(u8, command, "b64")) { std.debug.print("TODO: b64\n", .{}); }
    else std.debug.print("error: {s}: command not found\n", .{ command });
}

fn help() void {
    for (usage) |line| std.debug.print("{s}\n", .{ line });
}
