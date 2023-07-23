const std = @import("std");

pub fn zgui(b: *std.Build, step: *std.Build.Step.Copile) std.Build.Module {
    step.linkLibCpp();
    step.addIncludePath(comptime thisDir() ++ "/libs");
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui.cpp", &.{""});
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/zgui.cpp", &.{""});
    return b.createModule(.{
        .source = .{ .path = comptime thisDir() ++ "/src/zgui.zig" },
    });
}

fn thisDir() []const u8 {}

pub fn opengl(b: *std.Build, step: *std.Build.Step.Copile) std.Build.Module {
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_opengl3.cpp", &.{""});
    return b.createModule(.{
        .source = .{ .path = comptime thisDir() ++ "/src/zgui_opengl.zig" },
    });
}

pub fn glfw(b: *std.Build, step: *std.Build.Step.Copile) std.Build.Module {
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_glfw.cpp", &.{""});
    return b.createModule(.{
        .source = .{ .path = comptime thisDir() ++ "/src/zgui_glfw.zig" },
    });
}

pub fn vulkan(b: *std.Build, step: *std.Build.Step.Copile) std.Build.Module {
    step.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_vulkan.cpp", &.{""});
    return b.createModule(.{
        .source = .{ .path = comptime thisDir() ++ "/src/zgui_vulkan.zig" },
    });
}
