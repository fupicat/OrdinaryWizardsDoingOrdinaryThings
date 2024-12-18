extends CanvasLayer


var slide := -1
const Slides = [
    preload("res://scenes/levels/menu/instructions2.png"),
    preload("res://scenes/levels/menu/instructions3.png"),
    preload("res://scenes/levels/menu/instructions4.png"),
]

@export var play_scene: String

var main: Main

@onready var instructions := $Instructions
@onready var slide_texture := $Instructions/Button/TextureRect
@onready var sfx_click := $Instructions/Click

func _ready() -> void:
    instructions.hide()


func _on_play_pressed() -> void:
    instructions.show()


func _on_button_pressed() -> void:
    sfx_click.play()
    slide += 1
    if slide == 3:
        main.change_level(play_scene, 0.5)
        return
    slide_texture.texture = Slides[slide]


func _on_en_pressed() -> void:
    sfx_click.play()
    TranslationServer.set_locale("en")


func _on_br_pressed() -> void:
    sfx_click.play()
    TranslationServer.set_locale("pt")
