class_name Quest
extends Node2D


signal unlocked
signal wizard_entered(wizard: Wizard)
signal wizard_exited(wizard: Wizard)
signal job_opened
signal less_than_ten_seconds
signal job_closed
signal succeeded
signal failed
signal damaged(new_health: int)


@export var unlock_wait_time := 5.0
@export var base_job_wait_time := 5.0
@export var randomness := 2.0
@export var time_limit := 60.0:
    set(value):
        if job:
            job.time_limit = value
        time_limit = value
@export var health := 15:
    set(value):
        if job:
            job.max_health = value
        health = value
@export var auto_open_job := true
@export var cash_prize := 1
@export var wizard_costume: Texture
@export var royal_decree: Texture

@onready var target := $Target as Target
@onready var job := $Job as Job
@onready var timer := $Timer
@onready var unlock_timer := $UnlockTimer
@onready var sfx_selected := $Selected
@onready var sfx_targeted := $Targeted
@onready var sfx_incorrect := $Incorrect
@onready var sfx_hit := $Hit
@onready var sfx_job_open := $JobOpen

var locked := true
var job_open := false
var wizards: Array[Wizard] = []
var incoming_wizards: Array[Wizard] = []
var _less_than_ten_seconds_from_doom := false


func _ready() -> void:
    job.time_limit = time_limit
    job.max_health = health
    if unlock_wait_time == 0:
        unlock()
    else:
        unlock_timer.wait_time = unlock_wait_time
        unlock_timer.start()


func _process(_delta: float) -> void:
    if job.active:
        if not _less_than_ten_seconds_from_doom:
            if job.timer.time_left < 10:
                _less_than_ten_seconds_from_doom = true
                less_than_ten_seconds.emit()


func unlock() -> void:
    unlocked.emit()
    locked = false
    target.can_interact = true
    if auto_open_job:
        open_job()
    else:
        sleep()


func sleep() -> void:
    job_open = false
    job_closed.emit()
    timer.wait_time = base_job_wait_time + randf_range(-randomness, randomness)
    timer.start()


func open_job() -> void:
    if sfx_job_open:
        sfx_job_open.play()
    job_open = true
    job_opened.emit()
    job.activate()


func success() -> void:
    succeeded.emit()
    sleep()


func fail() -> void:
    failed.emit()
    sleep()


func add_wizard(wizard: Wizard) -> void:
    wizard.change_costume(wizard_costume)
    incoming_wizards.append(wizard)


func settle_wizard(wizard: Wizard) -> void:
    if wizard in incoming_wizards:
        incoming_wizards.erase(wizard)
        wizards.append(wizard)


func remove_wizard(wizard: Wizard) -> void:
    if wizard in incoming_wizards:
        incoming_wizards.erase(wizard)
        return
    wizards.erase(wizard)


func summon_random_wizard_to(quest: Quest) -> void:
    var wizard_pool: Array[Wizard] = wizards
    if incoming_wizards.size() > 0:
        wizard_pool = incoming_wizards
    if wizard_pool.size() == 0:
        sfx_incorrect.play()
        return
    var random_wizard := wizard_pool[randi_range(0, wizard_pool.size() - 1)]
    random_wizard.change_quest_to(quest)
    sfx_targeted.play()


func _on_job_defeated() -> void:
    success()


func _on_job_exploded() -> void:
    fail()


func _on_timer_timeout() -> void:
    open_job()


func _on_unlock_timer_timeout() -> void:
    unlock()


func _on_job_damaged() -> void:
    sfx_hit.play()
    damaged.emit(job.health)


func _on_target_selected() -> void:
    sfx_selected.play()
