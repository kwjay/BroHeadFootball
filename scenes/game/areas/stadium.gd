extends Node2D

signal goal_scored(team)

func _on_Goal_Scored(goalpost):
	if goalpost == "LeftGoalpost":
		emit_signal("goal_scored", "2")
	elif goalpost == "RightGoalpost":
		emit_signal("goal_scored", "1")

