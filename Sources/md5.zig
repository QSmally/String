
const std = @import("std");

const Md5 = std.crypto.hash.Md5;

pub fn perform(allocator: std.mem.Allocator, batch: []const u8) ![]u8 {
    var result: [Md5.digest_length]u8 = undefined;
    Md5.hash(batch, &result, .{});
    return try std.fmt.allocPrint(allocator, "{}", .{ std.fmt.fmtSliceHexLower(&result) });
}

test "md5" {
    const result = try perform(std.testing.allocator, "foo");
    try std.testing.expectEqualStrings("acbd18db4cc2f85cedef654fccc4a4d8", result);
    std.testing.allocator.free(result);
}
