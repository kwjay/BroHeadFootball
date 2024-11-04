extends Control

var game_time = 90
@onready var time_label = $HBoxContainer2/Time

func _ready():
	SoundFx.button_sounds(self)
	update_time_label()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_play_pressed():
	GameData.game_time = game_time
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


func update_time_label():
	var minutes = int(game_time / 60)
	var seconds = int(game_time) % 60
	var time_str = "%02d:%02d" % [minutes, seconds]
	time_label.text = str(time_str)

func _on_minus_pressed():
	if game_time > 30:
		game_time -= 30
	update_time_label()
		


func _on_plus_pressed():
	if game_time <= 180:
		game_time += 30
	update_time_label()
