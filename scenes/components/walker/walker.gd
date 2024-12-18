class_name Walker
extends Node


signal reached_target()
signal state_changed(state: Walker.State)


enum State {
    IDLE,
    WALKING,
}


@export var speed := 200
@export var root: Node2D


var target_position: Vector2
var at_target := true
var state: State = State.IDLE


func _ready() -> void:
    if not root:
        var parent := get_parent() as Node2D
        if parent:
            root = parent


func _process(delta: float) -> void:
    match state:
        State.IDLE:
            if at_target:
                return
            change_state(State.WALKING)
        State.WALKING:
            root.global_position = root.global_position.move_toward(
                    target_position, speed * delta)
            if root.global_position == target_position:
                at_target = true
                change_state(State.IDLE)
                reached_target.emit()


func change_state(new_state: State) -> void:
    state = new_state
    state_changed.emit(new_state)


func change_target_to(new_target_position: Vector2) -> void:
    at_target = false
    target_position = new_target_position
