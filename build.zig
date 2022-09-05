const std = @import("std");

pub fn linkImgui(exe: *std.build.LibExeObjStep) void {
    exe.linkLibCpp();
    exe.addIncludeDir(comptime thisDir() ++ "/libs");
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/zgui.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_glfw.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_opengl3.cpp", &.{""});
    exe.addCSourceFile(comptime thisDir() ++ "/libs/imgui/imgui_impl_vulkan.cpp", &.{""});
}

fn thisDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub const pkg = std.build.Pkg{
    .name = "zgui",
    .source = .{ .path = thisDir() ++ "/src/zgui.zig" },
};

pub const opengl = std.build.Pkg{
    .name = "zgui_opengl",
    .source = .{ .path = thisDir() ++ "/src/zgui_opengl.zig" },
};

pub const glfw = std.build.Pkg{
    .name = "zgui_glfw",
    .source = .{ .path = thisDir() ++ "/src/zgui_glfw.zig" },
};

pub const vulkan = std.build.Pkg{
    .name = "zgui_vulkan",
    .source = .{ .path = thisDir() ++ "/src/zgui_vulkan.zig" },
};
