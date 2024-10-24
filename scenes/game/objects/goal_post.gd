extends Node2D

var PUSH_FORCE = 10

signal goal_scored(goalpost)
func _on_goal_area_body_entered(body):
	if body.get_name() == "Ball":
		emit_signal("goal_scored", self.get_name())
	


func _on_sweep_area_body_entered(body):
	pass
