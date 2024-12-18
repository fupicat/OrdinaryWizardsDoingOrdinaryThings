class_name WizardCount
extends Control


signal all_wizards_dead


var count := 0:
    set(value):
        count = value
        if count <= 0:
            all_wizards_dead.emit()
        update_text()

@onready var label := $HBoxContainer/Label


func _ready() -> void:
    update_text()


func update_text() -> void:
    label.text = str(count)
