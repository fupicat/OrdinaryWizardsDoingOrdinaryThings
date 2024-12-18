extends AnimationPlayer



func _on_job_opened() -> void:
    play("bad")


func _on_job_closed() -> void:
    play("good")
