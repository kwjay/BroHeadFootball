extends Node2D

signal goal_scored(team)
func _ready():
	$LeftGoalpost.goal_area_entered.connect(_on_Goal_Scored)
	$RightGoalpost.goal_area_entered.connect(_on_Goal_Scored)

func _on_Goal_Scored(goalpost):
	if goalpost == "LeftGoalpost":
		emit_signal("goal_scored", "1")
	elif goalpost == "RightGoalpost":
		emit_signal("goal_scored", "2")
