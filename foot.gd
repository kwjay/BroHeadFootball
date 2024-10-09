extends CharacterBody2D

func _physics_process(delta):
	if Input.is_action_pressed("kick"):
		if position.x < 30:
			velocity.x = 200
		if position.y > 0:
			velocity.y = -100
	if position.x > 30 and position.x < 35:
		velocity.x = 0
	if position.y < 0 and position.y > -5:
		velocity.y = 0
	
	
	move_and_slide()

