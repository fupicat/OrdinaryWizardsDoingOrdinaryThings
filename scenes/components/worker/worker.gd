class_name Worker
extends Node


signal worked


@export var attack := 1
var job: Job


func assign_job(new_job: Job) -> void:
    job = new_job


func remove_job() -> void:
    job = null


func work() -> void:
    if not job:
        return
    worked.emit()
    job.damage(attack)
