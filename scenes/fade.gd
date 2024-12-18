class_name Fade
extends CanvasLayer


signal faded_in
signal faded_out


@onready var anim := $AnimationPlayer as AnimationPlayer


func fade_in(duration: float = 1.0) -> void:
    var speed := anim.get_animation("fade_in").length / duration
    anim.speed_scale = speed
    anim.play("fade_in")
    await anim.animation_finished


func fade_out(duration: float = 1.0) -> void:
    var speed := anim.get_animation("fade_out").length / duration
    anim.speed_scale = speed
    anim.play("fade_out")
    await anim.animation_finished
