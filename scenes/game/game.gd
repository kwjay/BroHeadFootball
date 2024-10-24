extends Node2D

var score_player1 = 0
var score_player2 = 0
const GAME_TIME = 180.0
var game_started = false

@onready var time_label = $GameMenu/UI/HBoxContainer/TimeLabel
@onready var score_label = $GameMenu/UI/HBoxContainer/ScoreLabel
@onready var ball_scene = preload("res://scenes/game/objects/football.tscn")
@onready var BALL_POSITION =  Vector2(get_viewport().size.x / 2, get_viewport().size.y / 4)
const PLAYER1_POSITION = Vector2(230, 460)
const PLAYER2_POSITION = Vector2(922, 460)



func _ready():
	set_timer_label(GAME_TIME)
	new_round()
	$GameTimer.start(GAME_TIME)

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
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	var time_str = "%02d:%02d" % [minutes, seconds]
	time_label.text = str(time_str)

func _on_goal_scored(goalpost):
	if goalpost == "LeftGoalPost":
		score_player2 += 1
	else:
		score_player1 += 1
	update_scores()
	await short_pause(1.0)
	new_round()
	
func new_round():
	$Player1.position = PLAYER1_POSITION
	$Player2.position = PLAYER2_POSITION
	await short_pause(1.0)

func update_scores():
	var score_str = "%1d:%1d" % [score_player1, score_player2]
	score_label.text = score_str
