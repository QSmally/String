
const std = @import("std");

const Md5 = std.crypto.hash.Md5;

pub fn perform(allocator: std.mem.Allocator, batch: []const u8) ![]u8 {
    var result: [Md5.digest_length]u8 = undefined;
    Md5.hash(batch, &result, .{});

    var output = try allocator.alloc(u8, 32);
    _ = try std.fmt.bufPrint(output, "{}", .{ std.fmt.fmtSliceHexLower(&result) });
    return output;
}

test "md5" {
    const result = try perform(std.testing.allocator, "foo");
    try std.testing.expectEqualStrings("acbd18db4cc2f85cedef654fccc4a4d8", result);
    std.testing.allocator.free(result);
}
