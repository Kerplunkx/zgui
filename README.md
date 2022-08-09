# ZGUI v0.1
It contains a clone of [zgui](https://github.com/michal-z/zig-gamedev/tree/main/libs/zgpu) by [michal-z](https://github.com/michal-z) along with custom bindings inspired by michal-z's wgpu bindings.

## Getting Started
Clone this repo, copy it to `root` of your project(`root/lib` is more preferred)
In your build.zig file, add
```zig
exe.linkLibC(); //To compile imgui
exe.linkLibCpp(); // To compile imgui
link_imgui(exe);
exe.addPackage(zgui);
exe.addPackage(zgui_glfw); //Make sure to add glfw as dependency (Prefered binding is mach_glfw)
exe.addPackage(zgui_opengl); //Add OpenGL support for Imgui
```
