
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
        var output = try allocator.alloc(u8, B64.Encoder.calcSize(batch.len));
        _ = B64.Encoder.encode(output, batch);
        allocator.free(batch);

        try stdout.print("{s}\n", .{ output });
        allocator.free(output);
    }
}
