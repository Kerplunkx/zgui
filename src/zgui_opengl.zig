extern fn ImGui_ImplOpenGL3_Init(glsl_version: [*:0]const u8) bool;
extern fn ImGui_ImplOpenGL3_Shutdown() void;
extern fn ImGui_ImplOpenGL3_NewFrame() void;
extern fn ImGui_ImplOpenGL3_RenderDrawData(draw_data: *const anyopaque) void;

pub fn init(glsl_version: [:0]const u8) !void {
    if (!ImGui_ImplOpenGL3_Init(glsl_version)) {
        return error.InitFailed;
    }
}

pub fn deinit() void {
    ImGui_ImplOpenGL3_Shutdown();
}

pub fn newFrame() void {
    ImGui_ImplOpenGL3_NewFrame();
}

pub fn render(draw_data: *const anyopaque) void {
    ImGui_ImplOpenGL3_RenderDrawData(draw_data);
}
