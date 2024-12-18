class_name GameOver
extends TextureRect


@onready var anim := $AnimationPlayer

var game_overed := false


func game_over(reason: Texture) -> void:
    if not game_overed:
        game_overed = true
        var tree := get_tree()
        if tree:
            tree.paused = true
            $Reason.texture = reason
            %MusicNormal.stop()
            %MusicIntense.stop()
            %MusicGameOver.play()
            anim.play("show")


func you_win(reason: Texture) -> void:
    if not game_overed:
        game_overed = true
        var tree := get_tree()
        if tree:
            tree.paused = true
            $Reason.texture = reason
            %MusicNormal.stop()
            %MusicIntense.stop()
            %MusicWin.play()
            anim.play("win")
