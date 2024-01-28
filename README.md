# zlvgl - zig binding for lvgl

## Code Example

```zig
const Ctx = struct {
    count: i32 = 0,
};

var _ctx = Ctx{};

const btn1 = lv.Button.init(lv.Screen.active());
_ = btn1.addEventCallback(&_ctx, struct {
    pub fn onClicked(event: anytype) void {
        const the_ctx = event.userData();
        the_ctx.count += 1;
        std.debug.print("Clicked, count: {d}\n", .{ the_ctx.count });
    }
});

btn1.setAlign(.Center, 0, -40);
const label = lv.Label.init(btn1);
label.setText("Button");
label.center();
```

## Build 

The following dependencies need to be met before build:

- zig: v0.11
- sdl2: for SDL2 backend
- gtk3: for GTK3 backend

## Run Example

```
$ zig build run
```

## Supported Features

### Platforms

- [x] Linux
- [ ] Windows
- [ ] Free Standing

### Backends

A backend manages display and input.

- [x] SDL2
- [x] GTK3
- [ ] Wayland
- [ ] Win32
- [ ] Free Standing

### Displays

- [x] LinuxFB
- [ ] DRM
- [ ] Custom Display

### LVGL Components

- [ ] Widgets
    - [x] Arc
    - [ ] Animation Image
    - [x] Bar
    - [x] Button
    - [ ] Button matrix
    - [ ] Calendar
    - [ ] Chart
    - [x] Canvas
    - [x] Checkbox
    - [ ] Drop-down list
    - [ ] Image
    - [ ] Image button
    - [ ] Keyboard
    - [x] Label
    - [ ] LED
    - [x] Line
    - [x] List
    - [ ] Menu
    - [ ] Message box
    - [ ] Roller
    - [ ] Scale
    - [x] Slider
    - [ ] Span
    - [ ] Spinbox
    - [ ] Spinner
    - [x] Switch
    - [x] Table
    - [x] Tabview
    - [ ] Text area
    - [ ] Tile view
    - [ ] Window

- [x] Events
- [x] Animations
- [ ] Styles
- [ ] Layouts
- [ ] Timers
- [ ] Fints
- [ ] Images