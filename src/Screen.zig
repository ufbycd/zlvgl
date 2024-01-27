const lv = @import("lv.zig");
const c = lv.c;

const Screen = @This();
obj: *c.lv_obj_t,

pub usingnamespace lv.Obj.Functions(Screen);

pub fn active() Screen {
    return .{
        .obj = c.lv_scr_act().?,
    };
}
