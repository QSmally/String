
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimisation = b.standardOptimizeOption(.{});

    const executable = b.addExecutable(.{
        .name = "TestZig",
        .root_source_file = .{ .path = "Sources/main.zig" },
        .target = target,
        .optimize = optimisation });
    b.installArtifact(executable);

    // Command
    const runc = b.addRunArtifact(executable);
    runc.step.dependOn(b.getInstallStep());
    if (b.args) |args| runc.addArgs(args);

    const runs = b.step("run", "Locally execute String");
    runs.dependOn(&runc.step);

    // Tests
    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimisation });
    const testc = b.addRunArtifact(unit_tests);

    const tests = b.step("test", "Run unit tests");
    tests.dependOn(&testc.step);
}
