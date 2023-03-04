
const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const executable = b.addExecutable("String", "Sources/main.zig");
    executable.setTarget(target);
    executable.setBuildMode(mode);
    executable.install();

    const runc = executable.run();
    runc.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        runc.addArgs(args);
    }

    const runs = b.step("run", "Locally execute String");
    runs.dependOn(&runc.step);

    const testc = b.addTest("Sources/main.zig");
    testc.setTarget(target);
    testc.setBuildMode(mode);

    const tests = b.step("test", "Test individual command components");
    tests.dependOn(&testc.step);
}
