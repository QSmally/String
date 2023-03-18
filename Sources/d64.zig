
const std = @import("std");

const B64 = std.base64.standard;

pub fn perform(allocator: std.mem.Allocator, batch: []const u8) ![]u8 {
    var output = try allocator.alloc(u8, try B64.Decoder.calcSizeUpperBound(batch.len));
    _ = try B64.Decoder.decode(output, batch);
    return output;
}

test "d64" {
    const result = try perform(std.testing.allocator, "Zm9v");
    try std.testing.expectEqualStrings("foo", result);
    std.testing.allocator.free(result);
}
