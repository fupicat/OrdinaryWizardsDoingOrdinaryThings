class_name RoyalDecree
extends TextureRect


@onready var anim := $AnimationPlayer


func pop(decree: Texture) -> void:
    texture = decree
    anim.stop()
    anim.play("pop")


func _on_mouse_entered() -> void:
    modulate = Color(1, 1, 1, 0.3)


func _on_mouse_exited() -> void:
    modulate = Color.WHITE
