
const std = @import("std");

const B64 = std.base64.standard;

pub fn perform(allocator: std.mem.Allocator, batch: []const u8) ![]u8 {
    var output = try allocator.alloc(u8, B64.Encoder.calcSize(batch.len));
    _ = B64.Encoder.encode(output, batch);
    return output;
}

test "e64" {
    const result = try perform(std.testing.allocator, "foo");
    try std.testing.expectEqualStrings("Zm9v", result);
    std.testing.allocator.free(result);
}
