extends Node


@onready var timer := $Timer as Timer
@onready var music_normal := %MusicNormal
@onready var music_intense := %MusicIntense


func activate() -> void:
    music_normal.volume_db = -80
    music_intense.volume_db = -8
    timer.start()


func deactivate() -> void:
    music_normal.volume_db = -8
    music_intense.volume_db = -80
    timer.stop()


func _on_timer_timeout() -> void:
    var wizards := get_tree().get_nodes_in_group("wizards")
    if wizards.size() == 0:
        return
    var random_wizard := wizards[randi_range(0, wizards.size() - 1)] as Wizard
    if random_wizard:
        random_wizard.die()
