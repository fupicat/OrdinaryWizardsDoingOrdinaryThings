class_name Wizard
extends Node2D


signal reached_quest
signal costume_changed


@export var initial_quest: Quest

@onready var walker := $Walker as Walker
@onready var worker := $Worker as Worker
@onready var attack_timer := $AttackTimer as Timer
@onready var root := $Root as Node2D
@onready var sprite := $Root/RootsAllTheWayDown/Normal as Sprite2D
const NormalCostume = preload("res://scenes/components/wizard/normal.png")

var quest: Quest
var at_quest := false


func _ready() -> void:
    change_quest_to(initial_quest)


func change_costume(new_costume: Texture) -> void:
    costume_changed.emit()
    if not new_costume:
        sprite.texture = NormalCostume
        return
    sprite.texture = new_costume


func change_quest_to(new_quest: Quest) -> void:
    if not new_quest:
        return
    if quest:
        quit_job()
        quest.remove_wizard(self)
        quest.job_opened.disconnect(_on_quest_job_opened)
        quest.succeeded.disconnect(quit_job)
        quest.failed.disconnect(quit_job)
    at_quest = false
    quest = new_quest
    quest.add_wizard(self)
    walker.change_target_to(quest.target.get_random_position())
    root.scale.x = 1 if walker.target_position.x > global_position.x else -1
    quest.job_opened.connect(_on_quest_job_opened)
    quest.succeeded.connect(quit_job)
    quest.failed.connect(quit_job)


func die() -> void:
    quest.remove_wizard(self)
    queue_free()


func take_available_job() -> void:
    if at_quest and quest.job_open:
        worker.assign_job(quest.job)
        attack_timer.start()


func quit_job() -> void:
    attack_timer.stop()
    worker.remove_job()


func _on_quest_job_opened() -> void:
    take_available_job()


func _on_walker_reached_target() -> void:
    quest.settle_wizard(self)
    at_quest = true
    reached_quest.emit()

    take_available_job()


func _on_attack_timer_timeout() -> void:
    worker.work()
