extends Node2D

const PUSH_FORCE = 150.0
const VELOCITY_THRESHOLD = 400.0

var ball_instance
var force_direction = Vector2(scale.x, 0)
signal goal_scored(goalpost)
func _on_goal_area_body_entered(body):
	if body.get_name() == "Ball":
		$GoalPostSFX/Net.play()
		emit_signal("goal_scored", self.get_name())
	
func _process(_delta):
	if (ball_instance != null):
		var current_speed = ball_instance.linear_velocity.length()
		if current_speed < 50.0:
			var force = force_direction.normalized() * PUSH_FORCE
			ball_instance.apply_force(force, Vector2.ZERO)

func _on_sweep_area_body_entered(body):
	if body.get_name() == "Ball":
		$GoalPostSFX/CrossbarHit.play()
		var current_speed = body.linear_velocity.length()
		if current_speed < VELOCITY_THRESHOLD:
			ball_instance = body


func _on_sweep_area_body_exited(body):
	if body.get_name() == "Ball":
		ball_instance = null
