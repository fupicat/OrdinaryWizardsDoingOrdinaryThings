extends Node2D

var selected_target: Target = null

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed:
        match event.button_index:
            MOUSE_BUTTON_RIGHT:
                if selected_target:
                    selected_target.deselect()
                selected_target = null
                get_viewport().set_input_as_handled()

func _ready() -> void:
    for node in get_tree().get_nodes_in_group("quests"):
        var target = node.target as Target
        target.selected.connect(func():
            if selected_target:
                selected_target.deselect()
            selected_target = target
        )


@onready var butt = $Button

func _on_button_pressed() -> void:
    if butt.text == 'Select':
        butt.text = 'Move'
    else:
        butt.text = 'Select'
