extends Button


@onready var anim := $AnimationPlayer
@onready var sfx_hover := $Hover
@onready var sfx_click := $Click


func _ready() -> void:
    mouse_entered.connect(func():
            if sfx_hover:
                sfx_hover.play()
            anim.play("hover"))
    mouse_exited.connect(func():
            anim.play("normal"))
    gui_input.connect(func(event: InputEvent):
            if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
                if event.pressed:
                    if sfx_click:
                        sfx_click.play()
                    anim.play("pressed")
                else:
                    anim.play("normal")
                )
