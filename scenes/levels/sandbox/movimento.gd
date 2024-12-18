extends Node2D

@onready var walker := $Icon/Walker as Walker
@onready var indicator := $Indicator
@onready var button := $Button

func _on_button_pressed() -> void:
    walker.change_target_to(indicator.global_position)

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_accept"):
        button.hide()

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.is_pressed():
        if event.button_index == MOUSE_BUTTON_LEFT:
            indicator.global_position = get_global_mouse_position()
            walker.change_target_to(indicator.global_position)

