const std = @import("std");
const lv = @import("lv.zig");
const c = lv.c;

pub const Button = @This();
obj: *c.lv_obj_t,

pub usingnamespace lv.Obj.Functions(Button);

pub fn init(parent: anytype) Button {
    return .{ .obj = c.lv_btn_create(parent.obj).? };
}

pub fn setText(self: Button, text: [:0]const u8) void {
    const child = self.getChild(0);
    if (child) |widget| {
        const label = widget.as(lv.Label);
        label.setText(text);
    } else {
        std.debug.print("Button have no child of Label!\n", .{});
    }
}
