const lv = @import("lv.zig");
const c = lv.c;

pub const Canvas = @This();
obj: *c.lv_obj_t,

usingnamespace lv.Obj.Functions(Canvas);

pub fn init(parent: anytype) Canvas {
    return .{
        .obj = c.lv_canvas_create(parent.obj).?,
    };
}

pub fn setBuffer(self: Canvas, buf: *anyopaque, w: lv.Coord, h: lv.Coord, cf: lv.ImgCf) void {
    c.lv_canvas_set_buffer(self.obj, buf, w, h, cf);
}

pub fn setPxColor(self: Canvas, x: lv.Coord, y: lv.Coord, color: lv.Color) void {
    c.lv_canvas_set_px_color(self.obj, x, y, color);
}
