extends Node2D


const WizardScene = preload("res://scenes/components/wizard/wizard.tscn")
const WizardExplosion = preload("res://scenes/components/wizard/wizard_explosion.tscn")
const NewWizSounds = [
    preload("res://sound/wizard_1.wav"),
    preload("res://sound/wizard_2.wav"),
]

@onready var home := $Home as Quest
@onready var lives := $UI/Control/Lives as Lives
@onready var money := $UI/Control/Money as Money
@onready var wizard_count := $UI/Control/WizardCount as WizardCount
@onready var game_over := $UI/Control/GameOver as GameOver
@onready var royal_decree := $UI/Control/RoyalDecree as RoyalDecree

@onready var sfx_new_wizard := $NewWiz

var selected_quest: Quest

var main: Main


func _ready() -> void:
    create_wizard()
    create_wizard()
    create_wizard()

    for node in get_tree().get_nodes_in_group("quests"):
        var quest := node as Quest
        if not node:
            continue
        quest.unlocked.connect(func():
                royal_decree.pop(quest.royal_decree))
        quest.target.selected.connect(func():
                if selected_quest and selected_quest != quest:
                    selected_quest.target.deselect()
                selected_quest = quest)
        quest.target.targeted.connect(func():
                if selected_quest and selected_quest != quest:
                    selected_quest.summon_random_wizard_to(quest))
        quest.failed.connect(lives.damage)
        quest.succeeded.connect(func():
                money.money += quest.cash_prize)


func create_wizard() -> void:
    wizard_count.count += 1
    var wizard = WizardScene.instantiate()
    wizard.initial_quest = $Home as Quest
    wizard.tree_exiting.connect(func():
            var explosion = WizardExplosion.instantiate()
            explosion.global_position = wizard.global_position
            explosion.scale = wizard.root.scale
            add_child.call_deferred(explosion)
            wizard_count.count -= 1)
    add_child(wizard)
    sfx_new_wizard.stream = NewWizSounds.pick_random()
    sfx_new_wizard.play()


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed:
        match event.button_index:
            MOUSE_BUTTON_RIGHT:
                if selected_quest:
                    selected_quest.target.deselect()
                    selected_quest = null
                get_viewport().set_input_as_handled()


func _on_wizard_button_pressed() -> void:
    if money.money >= 3:
        money.money -= 3
        create_wizard()


func _on_retry_pressed() -> void:
    main.change_level("res://scenes/levels/game/game.tscn")


func _on_wizard_count_all_wizards_dead() -> void:
    if money.money < 3:
        game_over.game_over(load("res://scenes/components/game_over/reason_wizards.png"))


func _on_lives_dead() -> void:
    game_over.game_over(load("res://scenes/components/game_over/reason_stars.png"))


func _on_home_job_opened() -> void:
    home.health = ceili(wizard_count.count * 2.5)


func _on_win_succeeded() -> void:
    game_over.you_win(load("res://scenes/components/game_over/reason_hired.png"))


func _on_menu_pressed() -> void:
    main.change_level("res://scenes/levels/menu/menu.tscn")
