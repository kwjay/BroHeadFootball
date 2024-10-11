extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
var PUSH_FORCE = 80.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("kick") and $"Foot".rotation > -2.5:
		$"Foot".rotation -= 20 * delta
	elif $"Foot".rotation < 0 and !Input.is_action_pressed("kick"):
		$"Foot".rotation += 10 * delta
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
	for i in get_slide_collision_count():
		var slide_collision = get_slide_collision(i)
		if slide_collision.get_collider() is RigidBody2D:
			slide_collision.get_collider().apply_central_impulse(-slide_collision.get_normal() * PUSH_FORCE)
