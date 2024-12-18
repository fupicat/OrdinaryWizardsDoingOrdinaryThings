class_name Money
extends HBoxContainer


@onready var sfx := $Good


var money := 0:
    set(value):
        if value > money and sfx:
            sfx.play()
        money = value
        update_text()

@onready var label := $Label


func _ready() -> void:
    update_text()


func update_text() -> void:
    label.text = str(money)
