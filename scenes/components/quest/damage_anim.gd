extends AnimationPlayer


func _on_damaged(_new_health: int) -> void:
    stop()
    play("damage")


func _on_succeeded() -> void:
    play("win")


func _on_failed() -> void:
    play("lose")


func _on_job_opened() -> void:
    play("damage")
