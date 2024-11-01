extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_play_pressed():
	GameData.game_time = 10
	GameData.player1_sprite = ""
	GameData.player2_sptite = ""
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_player1_sprite_right():
	pass # Replace with function body.


func _on_player1_sprite_left():
	pass # Replace with function body.


func _on_player2_sprite_left():
	pass # Replace with function body.


func _on_player2_sprite_right():
	pass # Replace with function body.
