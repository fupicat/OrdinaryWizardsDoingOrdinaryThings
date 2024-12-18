extends Node2D


@onready var sprite := $Sprite
@onready var camera := %Camera as Camera2D
@onready var anim := $AnimationPlayer

@onready var on_screen := ($ScreenNotif as VisibleOnScreenNotifier2D).is_on_screen()

var target_position := global_position


func _ready() -> void:
    hide()


func _process(_delta: float) -> void:
    if not visible:
        return

    if on_screen:
        target_position = to_global(Vector2.ZERO)
    else:
        target_position = to_global(Vector2.ZERO)

    sprite.global_position = sprite.global_position.lerp(target_position, 0.4)


func _on_screen_notif_screen_entered() -> void:
    on_screen = true


func _on_screen_notif_screen_exited() -> void:
    on_screen = false


func _on_job_opened() -> void:
    show()
    anim.play("normal")


func _on_less_than_ten_seconds() -> void:
    anim.play("hurry")


func _on_job_closed() -> void:
    hide()
