extends Camera2D


@export var zoom_smoothing := 0.4

@onready var viewport := get_viewport()

var pan_mouse_start_position: Vector2
var pan_camera_start_position: Vector2
var panning := false
var target_zoom := zoom


func _process(_delta: float) -> void:
    zoom = zoom.lerp(target_zoom, zoom_smoothing)
    if not panning:
        return
    position = (
        pan_camera_start_position + (
            pan_mouse_start_position - viewport.get_mouse_position()
        ) / zoom
    )


func _unhandled_input(event: InputEvent) -> void:
    if (
        event is InputEventKey \
        and event.keycode == KEY_SPACE \
        and not event.is_echo()
    ) or (
        event is InputEventMouseButton \
        and event.button_index == MOUSE_BUTTON_MIDDLE
    ):
        if event.is_pressed():
            pan_mouse_start_position = viewport.get_mouse_position()
            pan_camera_start_position = position
            panning = true
            viewport.set_input_as_handled()
        elif event.is_released():
            panning = false
            viewport.set_input_as_handled()
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_WHEEL_UP:
            target_zoom = target_zoom.move_toward(
                Vector2(2, 2), 0.1
            )
            viewport.set_input_as_handled()
        if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
            target_zoom = target_zoom.move_toward(
                Vector2(0.5, 0.5), 0.1
            )
            viewport.set_input_as_handled()
