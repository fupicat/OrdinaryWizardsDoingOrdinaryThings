class_name Vignette
extends TextureRect


var tween: Tween


func _ready() -> void:
    hide()


func appear() -> void:
    if tween:
        tween.kill()
    modulate = Color.TRANSPARENT
    show()
    tween = create_tween()
    tween.tween_property(self, "modulate", Color.WHITE, 0.6)


func disappear() -> void:
    if tween:
        tween.kill()
    tween = create_tween()
    tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.6)
    tween.tween_callback(hide)
