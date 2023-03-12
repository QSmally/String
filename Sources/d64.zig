
const std = @import("std");

const B64 = std.base64.standard;

pub fn perform(allocator: std.mem.Allocator, batch: []const u8) ![]u8 {
    var output = try allocator.alloc(u8, try B64.Decoder.calcSizeUpperBound(batch.len));
    _ = try B64.Decoder.decode(output, batch);
    return output;
}
