
const std = @import("std");

const stdin = std.io
    .getStdIn()
    .reader();
const stdout = std.io
    .getStdOut()
    .writer();
const Md5 = std.crypto.hash.Md5;

pub fn command(allocator: std.mem.Allocator) !void {
    while (try stdin.readUntilDelimiterOrEofAlloc(allocator, '\n', 1024)) |batch| {
        var output: [Md5.digest_length]u8 = undefined;
        Md5.hash(batch, &output, .{});
        allocator.free(batch);

        try stdout.print("{s}\n", .{ std.fmt.fmtSliceHexLower(&output) });
    }
}

test "md5 hash" {
    var output: [Md5.digest_length]u8 = undefined;
    Md5.hash("foo", &output, .{});

    try std.testing.expectEqualStrings(
        &[_]u8 { 172, 189, 24, 219, 76, 194, 248, 92, 237, 239, 101, 79, 204, 196, 164, 216 },
        &output);
}
