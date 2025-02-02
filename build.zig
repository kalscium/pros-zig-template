const std = @import("std");

pub fn build(b: *std.Build) void {
    // get the standard config options
    const optimize = b.standardOptimizeOption(.{});

    // define the vex v5 brain target
    const vex_v5_target = b.resolveTargetQuery(.{
        .cpu_arch = .thumb,
        .os_tag = .freestanding,
        .abi = .eabi,
        .cpu_model = .{ .explicit = &std.Target.arm.cpu.cortex_a9 },
        .cpu_features_add = std.Target.arm.featureSet(&.{
            .fp16,
            .neonfp,
        }),
    });

    // define the user-library
    const userlib = b.addObject(.{
        .name = "userlib",
        .root_source_file = b.path("src/main.zig"),
        .target = vex_v5_target,
        .optimize = optimize,
        .strip = true,
        .link_libc = false,
    });

    // add the pros header files and link libc
    userlib.addIncludePath(b.path("include"));

    // install the object (for the makefile)
    const obj_install = b.addInstallBinFile(userlib.getEmittedBin(), "userlib.zig.o");
    const install_obj = b.step("obj", "Builds the userlib as a .o file");
    install_obj.dependOn(&obj_install.step);
    b.getInstallStep().dependOn(&obj_install.step);

    // add a test step for the userlib
    const test_step = b.step("test", "Run unit tests");
    const local_target = b.standardTargetOptions(.{});
    const test_exe = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = local_target,
    });
    test_exe.addIncludePath(b.path("include"));
    const stubs = b.addStaticLibrary(.{
        .name = "stubs",
        .root_source_file = b.path("src/stub.zig"),
        .target = local_target,
        .optimize = optimize,
    });
    test_exe.linkLibrary(stubs);
    const run_tests = b.addRunArtifact(test_exe);
    test_step.dependOn(&run_tests.step);
}
