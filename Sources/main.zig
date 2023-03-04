
const std = @import("std");

const help = [_][]const u8 {
    "string - a tool to easily perform actions on strings.\n",
    "USAGE",
    "  string <operation> <string>",
    "  source | string <operation>",
    "  source | string <operation> | destination\n",
    "OPERATIONS",
    "  md5: generate an md5 hash",
    "  e64: encode into a base-64 string",
    "  d64: decode from a base-64 string" };
const stdout_file = std.io
    .getStdOut()
    .writer();

pub fn main() !void {
    var buffer = std.io.bufferedWriter(stdout_file);
    const stdout = buffer.writer();

    for (help) |string| {
        try stdout.print("{s}\n", .{ string });
    }

    try buffer.flush();
}
