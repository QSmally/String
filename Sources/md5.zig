
const std = @import("std");

const Md5 = std.crypto.hash.Md5;

pub fn perform(_: std.mem.Allocator, batch: []const u8) ![]u8 {
    // TODO: Allocator for heap instead of stack
    // var output = try allocator.alloc(u8, Md5.digest_length);
    var output: [Md5.digest_length]u8 = undefined;
    Md5.hash(batch, &output, .{});
    return &output;
}

test "md5" {
    try std.testing.expectEqualStrings(
        &[_]u8 { 172, 189, 24, 219, 76, 194, 248, 92, 237, 239, 101, 79, 204, 196, 164, 216 },
        try perform(std.testing.allocator, "foo"));
}
