const std = @import("std");

pub fn zgui(exe: *std.build.LibExeObjStep) std.build.Pkg {
    exe.linkLibCpp();
    exe.addIncludePath(comptime thisDir() ++ "/libs");
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/zgui.cpp", &.{""});
    return .{
        .name = "zgui",
        .source = .{ .path = comptime thisDir() ++ "/src/zgui.zig" },
    };
}

fn thisDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub fn opengl(exe: *std.build.LibExeObjStep) std.build.Pkg {
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_opengl3.cpp", &.{""});
    return .{
        .name = "zgui_opengl",
        .source = .{ .path = comptime thisDir() ++ "/src/zgui_opengl.zig" },
    };
}

pub fn glfw(exe: *std.build.LibExeObjStep) std.build.Pkg {
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_glfw.cpp", &.{""});
    return .{
        .name = "zgui_glfw",
        .source = .{ .path = comptime thisDir() ++ "/src/zgui_glfw.zig" },
    };
}

pub fn vulkan(exe: *std.build.LibExeObjStep) std.build.Pkg {
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_vulkan.cpp", &.{""});
    return .{
        .name = "zgui_vulkan",
        .source = .{ .path = comptime thisDir() ++ "/src/zgui_vulkan.zig" },
    };
}
