extends AnimationPlayer


func _on_target_hover() -> void:
    play("hover")


func _on_target_idle() -> void:
    play("idle")


func _on_target_selected() -> void:
    play("selected")


func _on_target_targeted() -> void:
    stop()
    play("target")
