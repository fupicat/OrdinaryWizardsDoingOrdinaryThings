class_name Main
extends Node2D


signal level_changed(new_level: Node)


@export var first_level: String
@export var initial_fade_in_duration: float = 1.0

@onready var fade := $Fade as Fade
var level: Node


func _ready() -> void:
    change_level(first_level, initial_fade_in_duration)


func change_level(path: String, fade_duration: float = 1.0) -> void:
    if level:
        await fade.fade_out(fade_duration)
        level.queue_free()
    get_tree().paused = false
    var scene := load(path) as PackedScene
    level = scene.instantiate()
    level.set("main", self)
    add_child(level)
    level_changed.emit(level)
    await fade.fade_in(fade_duration)
