extern fn ImGui_ImplGlfw_InitForOpenGL(window: *const anyopaque, install_callbacks: bool) bool;
extern fn ImGui_ImplGlfw_Shutdown() void;
extern fn ImGui_ImplGlfw_NewFrame() void;

pub fn initOpengl(window_handle: *const anyopaque, install_callbacks: bool) !void {
    if (!ImGui_ImplGlfw_InitForOpenGL(window_handle, install_callbacks)) {
        return error.InitFailed;
    }
}

pub fn deinit() void {
    ImGui_ImplGlfw_Shutdown();
}

pub fn newFrame() void {
    ImGui_ImplGlfw_NewFrame();
}
