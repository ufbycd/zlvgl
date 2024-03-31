const std = @import("std");
const lv = @import("zlvgl");
const Obj = lv.Obj;

const Ctx = struct {
    name: []const u8 = "count",
    count: i32 = 0,
};

var _ctx = Ctx{};

pub fn example_1() void {
    const btn1 = lv.Button.init(lv.Screen.active());
    _ = btn1.addEventCallback(&_ctx, struct {
        pub fn onClicked(event: anytype) void {
            const the_ctx = event.getUserData();
            the_ctx.count += 1;
            std.debug.print("Clicked, {s}: {d}\n", .{ the_ctx.name, the_ctx.count });
        }
    });

    btn1.setAlign(.Center, 0, -40);
    const label = lv.Label.init(btn1);
    label.setText("Button");
    label.center();

    const btn2 = lv.Button.init(lv.Screen.active());
    _ = btn2.addEventCallback(null, struct {
        pub fn onValueChanged(event: anytype) void {
            const target = event.getTarget();
            std.debug.print("Toggled: {s}\n", .{if (target.hasState(.Checked)) "checked" else "unchecked"});
        }
    });

    btn2.addFlag(.Checkable);
    btn2.setAlign(.Center, 0, 40);
    const label2 = lv.Label.init(btn2);
    label2.setText("Toggle");
    label2.center();
}

// TODO:example_2 and  3 with styles
