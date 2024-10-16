extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")
	self.queue_free()


func _on_help_pressed():
	print_debug("help pressed")


func _on_quit_pressed():
	get_tree().quit()
