const std = @import("std");
const glfw = @import("deps/mach-glfw/build.zig");
const zgui = @import("deps/zgui/build.zig");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    const exe = exampleExe(b, "glfw_opengl", mode, target);
    exe.addPackage(zgui.opengl(exe));
    exe.addPackage(zgui.glfw(exe));
}

fn exampleExe(b: *std.build.Builder, comptime name: []const u8, mode: std.builtin.Mode, target: std.zig.CrossTarget) *std.build.LibExeObjStep {
    const exe = b.addExecutable(name, "src/" ++ name ++ ".zig");
    exe.setBuildMode(mode);
    exe.setTarget(target);
    exe.addPackage(glfw.pkg);
    glfw.link(b, exe, .{
        .vulkan = false,
        .metal = false,
        .opengl = true,
    });
    exe.addPackage(zgui.zgui(exe));
    exe.install();

    const run_step = b.step(name, "Run " ++ name);
    const run_cmd = exe.run();
    run_step.dependOn(&run_cmd.step);

    return exe;
}
