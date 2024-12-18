extends Node2D

@onready var target := $Target as Target

func _ready() -> void:
    target.can_interact = true
