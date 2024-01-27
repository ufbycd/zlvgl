const std = @import("std");
const lv = @import("lv.zig");
const c = lv.c;

const Obj = @This();

obj: *c.lv_obj_t,

const Error = error{
    MissMatchCallback,
};

pub const State = enum(u16) {
    Default = c.LV_STATE_DEFAULT,
    Checked = c.LV_STATE_CHECKED,
    Focused = c.LV_STATE_FOCUSED,
    FocusKey = c.LV_STATE_FOCUS_KEY,
    Edited = c.LV_STATE_EDITED,
    Hovered = c.LV_STATE_HOVERED,
    Pressed = c.LV_STATE_PRESSED,
    Scrolled = c.LV_STATE_SCROLLED,
    Disabled = c.LV_STATE_DISABLED,
    User1 = c.LV_STATE_USER_1,
    User2 = c.LV_STATE_USER_2,
    User3 = c.LV_STATE_USER_3,
    User4 = c.LV_STATE_USER_4,
    Any = c.LV_STATE_ANY,

    pub fn integer(states: []const State) u16 {
        var value: u16 = 0;
        for (states) |state| {
            value |= @intFromEnum(state);
        }

        return value;
    }
};

pub const Flag = enum(u32) {
    Hidden = c.LV_OBJ_FLAG_HIDDEN,
    Clickable = c.LV_OBJ_FLAG_CLICKABLE,
    ClickFocusable = c.LV_OBJ_FLAG_CLICK_FOCUSABLE,
    Checkable = c.LV_OBJ_FLAG_CHECKABLE,
    Scrollable = c.LV_OBJ_FLAG_SCROLLABLE,
    SCROLL_ELASTIC = c.LV_OBJ_FLAG_SCROLL_ELASTIC,
    SCROLL_MOMENTUM = c.LV_OBJ_FLAG_SCROLL_MOMENTUM,
    SCROLL_ONE = c.LV_OBJ_FLAG_SCROLL_ONE,
    SCROLL_CHAIN_HOR = c.LV_OBJ_FLAG_SCROLL_CHAIN_HOR,
    SCROLL_CHAIN_VER = c.LV_OBJ_FLAG_SCROLL_CHAIN_VER,
    SCROLL_CHAIN = c.LV_OBJ_FLAG_SCROLL_CHAIN,
    SCROLL_ON_FOCUS = c.LV_OBJ_FLAG_SCROLL_ON_FOCUS,
    SCROLL_WITH_ARROW = c.LV_OBJ_FLAG_SCROLL_WITH_ARROW,
    SNAPPABLE = c.LV_OBJ_FLAG_SNAPPABLE,
    PRESS_LOCK = c.LV_OBJ_FLAG_PRESS_LOCK,
    EVENT_BUBBLE = c.LV_OBJ_FLAG_EVENT_BUBBLE,
    GESTURE_BUBBLE = c.LV_OBJ_FLAG_GESTURE_BUBBLE,
    ADV_HITTEST = c.LV_OBJ_FLAG_ADV_HITTEST,
    IGNORE_LAYOUT = c.LV_OBJ_FLAG_IGNORE_LAYOUT,
    FLOATING = c.LV_OBJ_FLAG_FLOATING,
    OVERFLOW_VISIBLE = c.LV_OBJ_FLAG_OVERFLOW_VISIBLE,

    LAYOUT_1 = c.LV_OBJ_FLAG_LAYOUT_1,
    LAYOUT_2 = c.LV_OBJ_FLAG_LAYOUT_2,

    WIDGET_1 = c.LV_OBJ_FLAG_WIDGET_1,
    WIDGET_2 = c.LV_OBJ_FLAG_WIDGET_2,
    USER_1 = c.LV_OBJ_FLAG_USER_1,
    USER_2 = c.LV_OBJ_FLAG_USER_2,
    USER_3 = c.LV_OBJ_FLAG_USER_3,
    USER_4 = c.LV_OBJ_FLAG_USER_4,

    pub fn integer(flags: []const Flag) u32 {
        var value: u32 = 0;
        for (flags) |flag| {
            value |= @intFromEnum(flag);
        }

        return value;
    }
};

pub fn init(parent: anytype) Obj {
    return .{
        .obj = c.lv_obj_create(parent.obj).?,
    };
}

pub usingnamespace Functions(Obj);

pub fn Functions(comptime Self: type) type {
    return struct {
        pub usingnamespace lv.Style.ObjFunctions(Self);

        pub fn assign(o: *c.lv_obj_t) Self {
            return .{ .obj = o };
        }

        pub fn as(self: Self, comptime Other: type) Other {
            return .{ .obj = self.obj };
        }

        pub fn asObj(self: Self) Obj {
            return .{ .obj = self.obj };
        }

        pub fn del(self: Self) void {
            c.lv_obj_del(self.obj);
        }

        pub fn setParent(self: Self, parent: anytype) void {
            c.lv_obj_set_parent(self.obj, parent.obj);
        }

        pub fn getChildCnt(self: Self) u32 {
            return c.lv_obj_get_child_cnt(self.obj);
        }

        pub fn getChild(self: Self, idx: u32) ?Obj {
            return if (c.lv_obj_get_child(self.obj, @as(i32, @intCast(idx)))) |obj| .{ .obj = obj } else null;
        }

        pub fn setSize(self: Self, width: i16, height: i16) void {
            c.lv_obj_set_size(self.obj, width, height);
        }

        pub fn setHeight(self: Self, height: i16) void {
            c.lv_obj_set_height(self.obj, height);
        }

        pub fn setWidth(self: Self, width: i16) void {
            c.lv_obj_set_width(self.obj, width);
        }

        pub fn setPos(self: Self, x: i16, y: i16) void {
            c.lv_obj_set_pos(self.obj, x, y);
        }

        pub fn center(self: Self) void {
            c.lv_obj_center(self.obj);
        }

        pub fn getParent(self: Self, comptime Parent: type) ?Parent {
            return if (c.lv_obj_get_parent(self.obj)) |obj|
                return .{ .obj = obj }
            else
                null;
        }

        pub fn setAlign(self: Self, align_: lv.Align, x_ofs: lv.Coord, y_ofs: lv.Coord) void {
            c.lv_obj_align(self.obj, @intFromEnum(align_), x_ofs, y_ofs);
        }

        pub fn setAlignTo(self: Self, base: anytype, align_: lv.Align, x_ofs: lv.Coord, y_ofs: lv.Coord) void {
            c.lv_obj_align_to(self.obj, base.obj, @intFromEnum(align_), x_ofs, y_ofs);
        }

        // flag
        pub fn addFlag(self: Self, flag: Obj.Flag) void {
            c.lv_obj_add_flag(self.obj, @intFromEnum(flag));
        }

        pub fn addFlags(self: Self, flags: []const Obj.Flag) void {
            c.lv_obj_add_flag(self.obj, Obj.Flag.integer(flags));
        }

        pub fn clearFlag(self: Self, flag: Obj.Flag) void {
            c.lv_obj_clear_flag(self.obj, @intFromEnum(flag));
        }

        pub fn clearFlags(self: Self, flags: []const Obj.Flag) void {
            c.lv_obj_clear_flag(self.obj, Obj.Flag.integer(flags));
        }

        // state
        pub fn addState(self: Self, state: Obj.State) void {
            c.lv_obj_add_state(self.obj, @intFromEnum(state));
        }

        pub fn addStates(self: Self, states: []const Obj.State) void {
            c.lv_obj_add_state(self.obj, Obj.State.integer(states));
        }

        pub fn clearState(self: Self, state: Obj.State) void {
            c.lv_obj_clear_state(self.obj, @intFromEnum(state));
        }

        pub fn clearStates(self: Self, states: []const Obj.State) void {
            c.lv_obj_clear_state(self.obj, Obj.State.integer(states));
        }

        pub fn getState(self: Self) u16 {
            return c.lv_obj_get_state(self.obj);
        }

        pub fn hasState(self: Self, state: Obj.State) bool {
            return c.lv_obj_has_state(self.obj, @intFromEnum(state));
        }

        pub fn flex(self: Self) lv.Flex {
            return lv.Flex{ .obj = self.obj };
        }

        fn generateWrapper(comptime callback: anytype, comptime UserDataType: type) lv.Event.Callback {
            return struct {
                fn f(e: ?*c.lv_event_t) callconv(.C) void {
                    const EventType = lv.Event.ThisEvent(Self, UserDataType);
                    const this_event = EventType{ .event = .{ .e = e.? } };

                    callback(this_event);
                }
            }.f;
        }

        pub fn addEventCallback(self: Self, user_data: anytype, comptime Callback: type) ?lv.Event.Callback {
            const UserDataType = @TypeOf(user_data);
            var the_user_data: ?*anyopaque = if (UserDataType != @TypeOf(null))
                @constCast(@ptrCast(user_data))
            else
                null;

            inline for (std.meta.fields(lv.Event.Code)) |field| {
                const callback_name = "on" ++ field.name;
                if (@hasDecl(Callback, callback_name)) {
                    const callback = @field(Callback, callback_name);
                    const wrapper = generateWrapper(callback, UserDataType);
                    _ = c.lv_obj_add_event_cb(self.obj, wrapper, field.value, the_user_data);
                    return wrapper;
                }
            }

            return null;
        }

        pub fn addEventCallbacks(self: Self, user_data: anytype, comptime Callbacks: type) usize {
            var added_count: usize = 0;
            const UserDataType = @TypeOf(user_data);
            var the_user_data: ?*anyopaque = if (UserDataType != @TypeOf(null))
                @constCast(@ptrCast(user_data))
            else
                null;

            inline for (std.meta.fields(lv.Event.Code)) |field| {
                const callback_name = "on" ++ field.name;
                if (@hasDecl(Callbacks, callback_name)) {
                    const callback = @field(Callbacks, callback_name);
                    const wrapper = generateWrapper(callback, UserDataType);
                    _ = c.lv_obj_add_event_cb(self.obj, wrapper, field.value, the_user_data);
                    added_count += 1;
                }
            }

            return added_count;
        }

        pub fn removeEventCallback(self: Self, callback: ?lv.Event.Callback) bool {
            return c.lv_obj_remove_event_cb(self.obj, callback);
        }
    };
}
