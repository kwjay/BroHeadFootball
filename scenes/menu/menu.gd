extends Control

func _on_play_pressed():
	print_debug("play pressed")


func _on_help_pressed():
	print_debug("help pressed")


func _on_quit_pressed():
	get_tree().quit()
