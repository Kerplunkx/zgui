extern fn ImGui_ImplVulkan_Init(info: *const anyopaque, render_pass: anyopaque) bool;
extern fn ImGui_ImplVulkan_Shutdown() void;
extern fn ImGui_ImplVulkan_NewFrame() void;
extern fn ImGui_ImplVulkan_RenderDrawData(draw_data: *const anyopaque, command_buffer: anyopaque, pipeline: anyopaque) void;

pub fn init(info: *const anyopaque, render_pass: anyopaque) !void {
    if (!ImGui_ImplVulkan_Init(info, render_pass)) {
        return error.InitFailed;
    }
}

pub fn deinit() void {
    ImGui_ImplVulkan_Shutdown();
}

pub fn newFrame() void {
    ImGui_ImplVulkan_NewFrame();
}

pub fn render(draw_data: *const anyopaque, command_buffer: anyopaque, pipeline: anyopaque) void {
    ImGui_ImplVulkan_RenderDrawData(draw_data, command_buffer, pipeline);
}
