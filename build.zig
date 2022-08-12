const std = @import("std");

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
