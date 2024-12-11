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

func play_music(track: int):
	var track_audio
	if track == 0:
		track_audio = $MenuMusic
	elif track == 1:
		track_audio = $GameMusic
	fade_in(track_audio)

func stop_track(track: int):
	var track_audio
	if track == 0:
		track_audio = $MenuMusic
	elif track == 1:
		track_audio = $GameMusic
	fade_out(track_audio)

func fade_in(track: AudioStreamPlayer2D):
	var tween := get_tree().create_tween()
	tween.tween_property(
		track,
		"volume_db", 
		-20,
		1.0
	)
	tween.set_trans(Tween.TRANS_LINEAR) 
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.finished.connect(track.play)

func fade_out(track: AudioStreamPlayer2D):
	var tween := get_tree().create_tween()
	tween.tween_property(
		track,
		"volume_db", 
		-80,
		1.0
	)
	tween.set_trans(Tween.TRANS_LINEAR) 
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(track.stop)
	
