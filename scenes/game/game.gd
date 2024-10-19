extends Node2D

@onready var ball_scene = preload("res://scenes/game/objects/football.tscn")
var BALL_POSITION
var PLAYER1_POSITION = Vector2(234, 440)
var PLAYER2_POSiTION = Vector2(879, 440)

func _ready():
	$Stadium.goal_scored.connect(_on_stadium_goal_scored)
	var screen_size = get_viewport().size
	BALL_POSITION = Vector2(screen_size.x / 2, screen_size.y / 4)
	$Ball.position = BALL_POSITION
	
func _on_stadium_goal_scored(team):
	match team:
		"1":
			$UI/Score1.text = str(int($UI/Score1.text) + 1)
		"2":
			$UI/Score2.text = str(int($UI/Score2.text) + 1)
	$Player1.position = PLAYER1_POSITION
	$Player2.position = PLAYER2_POSiTION
	$Ball.position = BALL_POSITION

