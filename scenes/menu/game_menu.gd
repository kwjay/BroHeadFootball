extends Control

func _on_sound_toggled(toggled_on):
	pass


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_pause_pressed():
	get_tree().paused = not get_tree().paused
