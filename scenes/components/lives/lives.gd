class_name Lives
extends TextureRect


signal dead

@onready var anim := $AnimationPlayer
@onready var sfx := $Damage


const Textures = [
    preload("res://scenes/components/lives/zero.png"),
    preload("res://scenes/components/lives/one.png"),
    preload("res://scenes/components/lives/two.png"),
    preload("res://scenes/components/lives/three.png"),
]

var lives := 3


func _ready() -> void:
    update_texture()


func update_texture() -> void:
    texture = Textures[lives]


func damage() -> void:
    if lives <= 0:
        return
    lives -= 1
    update_texture()
    anim.play("damage")
    sfx.play()
    if lives == 0:
        dead.emit()

