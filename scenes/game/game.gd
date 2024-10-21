extends Node2D

var score_player1 = 0
var score_player2 = 0
const GAME_TIME = 10.0
var game_started = false

#@onready var ball_scene = preload("res://scenes/game/objects/football.tscn")
#var BALL_POSITION
#const PLAYER1_POSITION = Vector2(234, 440)
#const PLAYER2_POSiTION = Vector2(879, 440)



func _ready():
	set_timer_label(GAME_TIME)
	await short_pause(1.0)
	$GameTimer.start(GAME_TIME)
	
	#$Stadium.goal_scored.connect(_on_stadium_goal_scored)
	#var screen_size = get_viewport().size
	#BALL_POSITION = Vector2(screen_size.x / 2, screen_size.y / 4)
	#$Ball.position = BALL_POSITION
	
#func _on_stadium_goal_scored(team):
	#match team:
		#"1":
			#$UI/Score1.text = str(int($UI/Score1.text) + 1)
		#"2":
			#$UI/Score2.text = str(int($UI/Score2.text) + 1)
	#$Player1.position = PLAYER1_POSITION
	#$Player2.position = PLAYER2_POSiTION
	#$Ball.position = BALL_POSITION

func _process(delta):
	set_timer_label($GameTimer.time_left)

func _on_game_timer_timeout():
	print_debug("game_ended")
	await short_pause(1.0)
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	
func short_pause(seconds):
	get_tree().paused = true
	await get_tree().create_timer(seconds).timeout
	get_tree().paused = false

func set_timer_label(time):
	var time_label = $GameMenu/UI/VBoxContainer/TimeLabel
	time_label.text = str(time)
