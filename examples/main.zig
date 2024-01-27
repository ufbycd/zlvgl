const std = @import("std");
const lv = @import("zlvgl");

pub fn main() !void {
    lv.init();
    defer lv.deinit();

    lv.drivers.init();
    defer lv.drivers.deinit();
    lv.drivers.register();

    // @import("arc.zig").example_2();
    // @import("bar.zig").example_3();
    @import("button.zig").example_1();

    var lastTick: i64 = std.time.milliTimestamp();
    while (true) {
        const curTick = std.time.milliTimestamp();
        lv.tick.inc(@intCast(curTick - lastTick));
        lastTick = curTick;
        //         lv.task.handler();
        const next_ms = lv.timer.handler();
        std.time.sleep(next_ms * 1_000_000); // sleep 10ms
    }
}
