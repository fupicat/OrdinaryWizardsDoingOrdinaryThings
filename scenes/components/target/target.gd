class_name Target
extends Node2D


signal hover
signal idle
## Selecting == right clicking to set where the walkers will
## come from.
signal selected
## Targeting == left clicking to send a walker from the selected
## target to this target.
signal targeted


@onready var _collision := $Area2D/CollisionShape2D as CollisionShape2D


var can_interact := false
var _hovering := false
var is_selected := false


func get_random_position() -> Vector2:
    var shape := _collision.shape
    if shape is CircleShape2D:
        var rand_angle := Vector2.from_angle(randf_range(0, TAU))
        var rand_radius := randf_range(shape.radius / 2, shape.radius)
        return _collision.global_position + rand_angle * rand_radius

    return _collision.global_position


func select() -> void:
    is_selected = true
    selected.emit()


func deselect() -> void:
    is_selected = false
    idle.emit()


func target() -> void:
    targeted.emit()


func _unhandled_input(event: InputEvent) -> void:
    if not can_interact:
        return
    if event is InputEventMouseButton and event.pressed and _hovering:
        match event.button_index:
            MOUSE_BUTTON_LEFT:
                if not is_selected:
                    target()
                get_viewport().set_input_as_handled()
            MOUSE_BUTTON_RIGHT:
                if not is_selected:
                    select()
                get_viewport().set_input_as_handled()


func _on_area_2d_mouse_entered() -> void:
    _hovering = true
    if not is_selected:
        hover.emit()


func _on_area_2d_mouse_exited() -> void:
    _hovering = false
    if not is_selected:
        idle.emit()
