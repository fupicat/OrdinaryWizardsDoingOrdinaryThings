extends AnimationPlayer

@onready var second := $SecondaryAnim

func _ready() -> void:
    play("idle")
    seek(randf_range(0, 2))

func _on_walker_state_changed(state: Walker.State) -> void:
    match state:
        Walker.State.IDLE:
            play("idle")
        Walker.State.WALKING:
            play("walking")

func _on_wizard_costume_changed() -> void:
    second.play("change_costume")

func _on_worker_worked() -> void:
    second.play("attack")
