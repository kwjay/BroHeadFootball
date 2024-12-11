extends Control

func _ready():
	SoundFx.button_sounds(self)

func _on_sound_toggled(toggled_on):
	if toggled_on:
		SoundFx.stop_track(1)
	else:
		SoundFx.play_music(1)


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_pause_pressed():
	get_tree().paused = not get_tree().paused
