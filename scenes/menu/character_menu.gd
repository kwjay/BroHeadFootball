extends Control

func _ready():
	SoundFx.button_sounds(self)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_play_pressed():
	GameData.game_time = 180
	GameData.player1_sprite = ""
	GameData.player2_sptite = ""
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_player1_sprite_right():
	pass

func _on_player1_sprite_left():
	pass

func _on_player2_sprite_left():
	pass


func _on_player2_sprite_right():
	pass
