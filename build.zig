const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    {
        const exe = exampleExe(b, "glfw_opengl", mode, target);
        exe.addPackage(zgui_opengl);
        exe.addPackage(zgui_glfw);
    }
}

fn exampleExe(b: *std.build.Builder, comptime name: []const u8, mode: std.builtin.Mode, target: std.zig.CrossTarget) *std.build.LibExeObjStep {
    const exe = b.addExecutable(name, "examples/" ++ name ++ ".zig");
    exe.setBuildMode(mode);
    exe.setTarget(target);
    const glfw = @import("examples/deps/mach-glfw/build.zig");
    link_imgui(exe);
    exe.addPackage(glfw.pkg);
    glfw.link(b, exe, .{
        .vulkan = false,
        .metal = false,
        .opengl = true,
    });
    exe.addPackage(zgui);
    exe.install();

    const run_step = b.step(name, "Run " ++ name);
    const run_cmd = exe.run();
    run_step.dependOn(&run_cmd.step);

    return exe;
}

pub fn link_imgui(exe: *std.build.LibExeObjStep) void {
    exe.linkLibC();
    exe.linkLibCpp();
    exe.addIncludeDir(thisDir() ++ "/libs");
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/zgui.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_impl_glfw.cpp", &.{""});
    exe.addCSourceFile(thisDir() ++ "/libs/imgui/imgui_impl_opengl3.cpp", &.{""});
}

fn thisDir() []const u8 {
    comptime {
        return std.fs.path.dirname(@src().file) orelse ".";
    }
}

pub const zgui = std.build.Pkg{
    .name = "zgui",
    .source = .{ .path = thisDir() ++ "/src/zgui.zig" },
};

pub const zgui_opengl = std.build.Pkg{
    .name = "zgui_opengl",
    .source = .{ .path = thisDir() ++ "/src/zgui_opengl.zig" },
};

pub const zgui_glfw = std.build.Pkg{
    .name = "zgui_glfw",
    .source = .{ .path = thisDir() ++ "/src/zgui_glfw.zig" },
};
