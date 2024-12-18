extends Node2D


@export var number := 10

@onready var label := $Label

var velocity: Vector2
var gravity := 10


func _ready() -> void:
    velocity = Vector2(randf_range(-100, 100), randf_range(-30, -300))
    label.text = str(number)
    var tween = get_tree().create_tween()
    tween.tween_property(
            label, "modulate", Color.TRANSPARENT, 1
    ).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
    tween.tween_callback(queue_free)

func _process(delta: float) -> void:
    velocity.y += gravity
    label.position += velocity * delta
