const std = @import("std");

pub fn zgui(exe: *std.build.LibExeObjStep) std.build.Pkg {
    const path = comptime std.fs.path.dirname(@src().file) orelse ".";
    exe.linkLibCpp();
    exe.addIncludeDir(path ++ "/libs");
    exe.addCSourceFile(path ++ "/libs/imgui/imgui.cpp", &.{""});
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_widgets.cpp", &.{""});
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_tables.cpp", &.{""});
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_draw.cpp", &.{""});
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_demo.cpp", &.{""});
    exe.addCSourceFile(path ++ "/libs/imgui/zgui.cpp", &.{""});
    return .{
        .name = "zgui",
        .source = .{ .path = path ++ "/src/zgui.zig" },
    };
}

pub fn vulkan(exe: *std.build.LibExeObjStep) std.build.Pkg {
    const path = comptime std.fs.path.dirname(@src().file) orelse ".";
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_impl_vulkan.cpp", &.{""});
    return .{
        .name = "zgui_vulkan",
        .source = .{ .path = path ++ "/src/zgui_vulkan.zig" },
    };
}

pub fn opengl(exe: *std.build.LibExeObjStep) std.build.Pkg {
    const path = comptime std.fs.path.dirname(@src().file) orelse ".";
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_impl_opengl3.cpp", &.{""});
    return .{
        .name = "zgui_opengl",
        .source = .{ .path = path ++ "/src/zgui_opengl.zig" },
    };
}

pub fn glfw(exe: *std.build.LibExeObjStep) std.build.Pkg {
    const path = comptime std.fs.path.dirname(@src().file) orelse ".";
    exe.addCSourceFile(path ++ "/libs/imgui/imgui_impl_glfw.cpp", &.{""});
    return .{
        .name = "zgui_glfw",
        .source = .{ .path = path ++ "/src/zgui_glfw.zig" },
    };
}
