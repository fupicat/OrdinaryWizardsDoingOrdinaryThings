class_name Job
extends Node


signal damaged()
signal activated()
signal defeated()
signal exploded()


@export var max_health := 15
@export var time_limit := 60.0

@onready var timer := $Timer as Timer
var health := max_health
var active := false


func activate() -> void:
    activated.emit()
    active = true
    health = max_health
    if time_limit != 0:
        timer.wait_time = time_limit
        timer.start()


func damage(amount := 1) -> void:
    if health > 0:
        health -= amount
        damaged.emit()
        if health <= 0:
            defeat()


func defeat() -> void:
    active = false
    timer.stop()
    defeated.emit()


func explode() -> void:
    active = false
    exploded.emit()


func _on_timer_timeout() -> void:
    explode()
