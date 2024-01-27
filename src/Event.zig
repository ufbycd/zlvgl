const std = @import("std");
const lv = @import("lv.zig");
const c = lv.c;

const Event = @This();

e: *c.lv_event_t,

pub const Code = enum(isize) {
    All = c.LV_EVENT_ALL,
    Pressed = c.LV_EVENT_PRESSED,
    Pressing = c.LV_EVENT_PRESSING,
    PressLost = c.LV_EVENT_PRESS_LOST,
    ShortClicked = c.LV_EVENT_SHORT_CLICKED,
    LongPressed = c.LV_EVENT_LONG_PRESSED,
    LongPressedRepeat = c.LV_EVENT_LONG_PRESSED_REPEAT,
    Clicked = c.LV_EVENT_CLICKED,
    Released = c.LV_EVENT_RELEASED,
    ScrollBegin = c.LV_EVENT_SCROLL_BEGIN,
    ScrollEnd = c.LV_EVENT_SCROLL_END,
    Scroll = c.LV_EVENT_SCROLL,
    Gesture = c.LV_EVENT_GESTURE,
    Key = c.LV_EVENT_KEY,
    Focused = c.LV_EVENT_FOCUSED,
    Defocused = c.LV_EVENT_DEFOCUSED,
    Leave = c.LV_EVENT_LEAVE,
    HitTest = c.LV_EVENT_HIT_TEST,
    CoverCheck = c.LV_EVENT_COVER_CHECK,
    RefrExtDrawSize = c.LV_EVENT_REFR_EXT_DRAW_SIZE,
    DrawMainBegin = c.LV_EVENT_DRAW_MAIN_BEGIN,
    DrawMain = c.LV_EVENT_DRAW_MAIN,
    DrawMainEnd = c.LV_EVENT_DRAW_MAIN_END,
    DrawPostBegin = c.LV_EVENT_DRAW_POST_BEGIN,
    DrawPost = c.LV_EVENT_DRAW_POST,
    DrawPostEnd = c.LV_EVENT_DRAW_POST_END,
    DrawPartBegin = c.LV_EVENT_DRAW_PART_BEGIN,
    DrawPartEnd = c.LV_EVENT_DRAW_PART_END,
    ValueChanged = c.LV_EVENT_VALUE_CHANGED,
    Insert = c.LV_EVENT_INSERT,
    Refresh = c.LV_EVENT_REFRESH,
    Ready = c.LV_EVENT_READY,
    Cancel = c.LV_EVENT_CANCEL,
    Delete = c.LV_EVENT_DELETE,
    ChildChanged = c.LV_EVENT_CHILD_CHANGED,
    ChildCreated = c.LV_EVENT_CHILD_CREATED,
    ChildDeleted = c.LV_EVENT_CHILD_DELETED,
    ScreenUnloadStart = c.LV_EVENT_SCREEN_UNLOAD_START,
    ScreenLoadStart = c.LV_EVENT_SCREEN_LOAD_START,
    ScreenLoaded = c.LV_EVENT_SCREEN_LOADED,
    ScreenUnloaded = c.LV_EVENT_SCREEN_UNLOADED,
    SizeChanged = c.LV_EVENT_SIZE_CHANGED,
    StyleChanged = c.LV_EVENT_STYLE_CHANGED,
    LayoutChanged = c.LV_EVENT_LAYOUT_CHANGED,
    GetSelfSize = c.LV_EVENT_GET_SELF_SIZE,

    const defaultIdMax = c._LV_EVENT_LAST;
    const preprocess = c.LV_EVENT_PREPROCESS;

    pub fn toId(self: Code) isize {
        return @intFromEnum(self);
    }
};

pub const Callback = *const fn (?*c.lv_event_t) callconv(.C) void;

pub fn ThisEvent(comptime ObjType: type, comptime UserDataType: type) type {
    return struct {
        event: lv.Event,

        pub fn target(self: @This()) ObjType {
            return ObjType{ .obj = self.event.target().obj };
        }

        pub fn userData(self: @This()) UserDataType {
            return self.event.userData(UserDataType);
        }

        pub fn code(self: @This()) Code {
            return self.event.code();
        }
    };
}

pub fn target(self: Event) lv.Obj {
    return lv.Obj{ .obj = self.e.target.? };
}

pub fn userData(self: Event, comptime DataType: type) DataType {
    return @alignCast(@ptrCast(self.e.user_data));
}

pub fn param(self: Event, comptime ParamType: type) ParamType {
    return @alignCast(@ptrCast(self.e.param));
}

pub fn eventId(self: Event) isize {
    return self.e.*.code;
}

pub fn code(self: Event) Code {
    return @enumFromInt(self.eventId());
}

pub fn stopBubbling(self: Event) void {
    c.lv_event_stop_bubbling(self.e);
}

pub fn stopProcessing(self: Event) void {
    c.lv_event_stop_processing(self.e);
}

pub fn registerId() isize {
    return @intCast(c.lv_event_register_id());
}

pub fn send(obj: anytype, event_id: isize, param_: ?*anyopaque) lv.Res {
    return c.lv_event_send(obj.obj, event_id, param_);
}
