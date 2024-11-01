extends RigidBody2D

var ball_position = Vector2.ZERO
var reset_position = false
func stop_and_set_position(new_position:Vector2):
	reset_position = true
	self.linear_velocity = Vector2.ZERO
	self.angular_velocity = 0
	ball_position = new_position
	self.transform.origin = ball_position

func _integrate_forces(state):
	if reset_position:
		reset_position = false 
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		state.transform.origin = ball_position

