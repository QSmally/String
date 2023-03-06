
const std = @import("std");

const stdin = std.io
    .getStdIn()
    .reader();
const stdout = std.io
    .getStdOut()
    .writer();
const B64 = std.base64.standard;

pub fn command(allocator: std.mem.Allocator) !void {
    while (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |batch| {
        var output = try allocator.alloc(u8, try B64.Decoder.calcSizeUpperBound(batch.len));
        _ = try B64.Decoder.decode(output, batch);
        allocator.free(batch);

        try stdout.print("{s}\n", .{ output });
        allocator.free(output);
    }
}
