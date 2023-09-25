const std = @import("std");

pub fn zgui(b: *std.Build, step: *std.Build.Step.Compile) *std.Build.Module {
    step.linkLibCpp();
    step.addIncludePath(.{ .path = comptime thisDir() ++ "/libs" });
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui.cpp" }, .flags = &.{""} });
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_widgets.cpp" }, .flags = &.{""} });
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_tables.cpp" }, .flags = &.{""} });
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_draw.cpp" }, .flags = &.{""} });
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_demo.cpp" }, .flags = &.{""} });
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/zgui.cpp" }, .flags = &.{""} });
    return b.createModule(.{
        .source_file = .{ .path = comptime thisDir() ++ "/src/zgui.zig" },
    });
}

inline fn thisDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub fn opengl(b: *std.Build, step: *std.Build.Step.Compile) *std.Build.Module {
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_impl_opengl3.cpp" }, .flags = &.{""} });
    return b.createModule(.{
        .source_file = .{ .path = comptime thisDir() ++ "/src/zgui_opengl.zig" },
    });
}

pub fn glfw(b: *std.Build, step: *std.Build.Step.Compile) *std.Build.Module {
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_impl_glfw.cpp" }, .flags = &.{""} });
    return b.createModule(.{
        .source_file = .{ .path = comptime thisDir() ++ "/src/zgui_glfw.zig" },
    });
}

pub fn vulkan(b: *std.Build, step: *std.Build.Step.Compile) *std.Build.Module {
    step.addCSourceFile(.{ .file = .{ .path = comptime thisDir() ++ "/libs/imgui/imgui_impl_vulkan.cpp" }, .flags = &.{""} });
    return b.createModule(.{
        .source_file = .{ .path = comptime thisDir() ++ "/src/zgui_vulkan.zig" },
    });
}
