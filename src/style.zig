const std = @import("std");
const lv = @import("lv.zig");
const c = lv.c;

style: *c.lv_style_t,

const Style = @This();

pub const Part = enum(u32) {
    Main = c.LV_PART_MAIN,
    Scrollbar = c.LV_PART_SCROLLBAR,
    Indicator = c.LV_PART_INDICATOR,
    Knob = c.LV_PART_KNOB,
    Selected = c.LV_PART_SELECTED,
    Items = c.LV_PART_ITEMS,
    Ticks = c.LV_PART_TICKS,
    Cursor = c.LV_PART_CURSOR,

    pub const CustomFirst = c.LV_PART_CUSTOM_FIRST;
    pub const Any = c.LV_PART_ANY;

    pub fn toInt(self: Part) u32 {
        return @intFromEnum(self);
    }
};

pub const Prop = enum(u32) {
    Inv = c.LV_STYLE_PROP_INV,
};

pub const BaseDir = enum(u8) {
    Ltr = c.LV_BASE_DIR_LTR,
    Rtl = c.LV_BASE_DIR_RTL,
    Auto = c.LV_BASE_DIR_AUTO,

    Neutral = c.LV_BASE_DIR_NEUTRAL,
    Weak = c.LV_BASE_DIR_WEAK,
    _,
};

pub fn init(style: *c.lv_style_t) Style {
    c.lv_style_init(style);
    return .{ .style = style };
}

pub fn reset(self: Style) void {
    c.lv_style_reset(self.style);
}

pub fn ObjFunctions(comptime Self: type) type {
    return struct {
        pub fn getStyleProp(self: Self, prop: Style.Prop, value: *c.lv_style_value_t) u8 {
            return c.lv_style_get_prop(self.obj, prop, value);
        }

        pub fn removeStyle(self: Self, style: ?*anyopaque, selector: Style.Part) void {
            _ = style;
            c.lv_obj_remove_style(self.obj, null, @intFromEnum(selector));
        }

        pub fn setStyleBaseDir(self: Self, value: Style.BaseDir, selector: Style.Part) void {
            c.lv_obj_set_style_base_dir(self.obj, @intFromEnum(value), @intFromEnum(selector));
        }

        // TODO add more functions from C
    };
}
