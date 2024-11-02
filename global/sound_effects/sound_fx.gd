extends Node

func _ready():
	$Crowd.play()

func button_click():
	$ButtonClick.play()

func button_sounds(node: Node):
	for i in node.get_children():
		if i is Button:
			i.pressed.connect(sfx_play.bind($ButtonClick))
		button_sounds(i)

func sfx_play(sound : AudioStreamPlayer2D):
	sound.play()
