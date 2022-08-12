const zgui = @import("zgui");
const zgui_glfw = @import("zgui_glfw");
const zgui_opengl = @import("zgui_opengl");
const glfw = @import("glfw");
const gl = @import("gl3.zig");

const std = @import("std");
const width = 600;
const height = 400;
const title = "OpenGL-MachGLFW";

fn glGetProcAddress(p: ?*anyopaque, proc: [:0]const u8) ?*const anyopaque {
    _ = p;
    return glfw.getProcAddress(proc);
}

pub fn main() void {
    glfw.init(.{}) catch |err| {
        std.log.err("Failed Initialising GLFW: {}", .{err});
        return;
    };

    defer glfw.terminate();

    const window: glfw.Window = glfw.Window.create(width, height, title, null, null, .{
        .context_version_major = 3,
        .context_version_minor = 3,
        .opengl_profile = .opengl_core_profile,
        .opengl_forward_compat = true,
    }) catch |err| {
        std.log.err("Failed Creating Window: {}", .{err});
        return;
    };

    defer window.destroy();

    glfw.makeContextCurrent(window) catch |err| {
        std.log.err("Cannot make context current: {}", .{err});
        return;
    };
    glfw.swapInterval(1) catch |err| {
        std.log.err("Cannot enable VSync: {}", .{err});
        return;
    };

    gl.load(@as(?*anyopaque, null), glGetProcAddress) catch |err| {
        std.log.err("Failed loading GL functions: {}", .{err});
        return;
    };

    const glsl_version: [:0]const u8 = "#version 330 core";
    zgui.init();
    defer zgui.deinit();

    zgui_glfw.initOpengl(window.handle, true) catch |err| {
        std.log.err("{}", .{err});
        return;
    };
    defer zgui_glfw.deinit();
    zgui_opengl.init(glsl_version) catch |err| {
        std.log.err("{}", .{err});
        return;
    };
    defer zgui_opengl.deinit();

    var show_demo: bool = true;

    while (!window.shouldClose()) {
        glfw.pollEvents() catch |err| {
            std.log.err("Error Capturing Events: {}", .{err});
            return;
        };

        zgui_opengl.newFrame();
        zgui_glfw.newFrame();
        zgui.newFrame();

        zgui.showDemoWindow(&show_demo);

        zgui.render();
        const size = window.getFramebufferSize() catch |err| {
            std.log.err("{}", .{err});
            return;
        };
        gl.viewport(0, 0, @intCast(c_int, size.width), @intCast(c_int, size.height));
        gl.clearColor(1, 0, 0, 1);
        gl.clear(gl.COLOR_BUFFER_BIT);
        zgui_opengl.render(zgui.getDrawData());
        window.swapBuffers() catch |err| {
            std.log.err("Error Swapping Buffers: {}", .{err});
            return;
        };
    }
}
