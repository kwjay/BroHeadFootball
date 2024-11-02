extends Node2D

var score_player1 = 0
var score_player2 = 0
var game_started = false

@onready var game_time = GameData.game_time
@onready var time_label = $GameMenu/UI/HBoxContainer/TimeLabel
@onready var score_label = $GameMenu/UI/HBoxContainer/ScoreLabel
@onready var ball_scene = $Ball
@onready var go_label = $GameMenu/UI/Go
@onready var sfx = $GameSFX
@onready var BALL_POSITION =  Vector2(get_viewport().size.x / 2, get_viewport().size.y / 4)
const PLAYER1_POSITION = Vector2(230, 460)
const PLAYER2_POSITION = Vector2(922, 460)



func _ready():
	set_timer_label(game_time)
	new_round()
	$GameTimer.start(game_time)

func _process(_delta):
	set_timer_label($GameTimer.time_left)

func _on_game_timer_timeout():
	sfx.fin_de_match.play()
	go_label.text = "Final score"
	go_label.visible = true
	await short_pause(1.0)
	go_label.text = str(score_player1) + ":" + str(score_player2)
	await short_pause(2.0)
	go_label.visible = false
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
	var player_name
	if goalpost == "LeftGoalPost":
		player_name = $Player2.name
		score_player2 += 1
	else:
		player_name = $Player1.name
		score_player1 += 1
	sfx.crowd_goal_scored.play()
	update_scores()
	go_label.visible = true
	go_label.text = player_name + " scored"
	await short_pause(1.0)
	go_label.visible = false
	new_round()
	
func new_round():
	ball_scene.stop_and_set_position(BALL_POSITION)
	$Player1.position = PLAYER1_POSITION
	$Player2.position = PLAYER2_POSITION
	go_label.text = "3"
	go_label.visible = true
	await short_pause(1.0)
	go_label.text = "2"
	await short_pause(1.0)
	go_label.text = "1"
	await short_pause(1.0)
	go_label.text = "GO"
	sfx.kick_off.play()
	await get_tree().create_timer(1.0).timeout
	go_label.visible = false

func update_scores():
	var score_str = "%1d:%1d" % [score_player1, score_player2]
	score_label.text = score_str
