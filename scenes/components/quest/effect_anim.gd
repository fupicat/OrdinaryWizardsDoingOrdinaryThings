extends AnimationPlayer



func _on_quest_succeeded() -> void:
    play("win")


func _on_quest_failed() -> void:
    play("lose")
