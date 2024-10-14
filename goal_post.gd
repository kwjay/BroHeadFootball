extends Node2D

signal goal_area_entered(goalpost)
func _on_goal_area_body_entered(body):
	if body.get_name() == "Ball":
		emit_signal("goal_area_entered", self.get_name())
	
