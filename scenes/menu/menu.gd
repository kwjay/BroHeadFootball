extends Control

func _ready():
	SoundFx.button_sounds(self)
	SoundFx.play_music(0)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/character_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
