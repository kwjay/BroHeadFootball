extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -350.0
const PUSH_FORCE = 100.0
const HEADER_FORCE = 150.0
const FOOT_MAX_ROTATION = -1.7
const KICK_FORCE = 250.0
const FOOT_RESET_SPEED = 10.0
const FOOT_KICK_SPEED = 15.0

@export var WSAD = true
@onready var foot = $Foot

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_controls = {
		"jump": "jump" if WSAD else "jump2",
		"kick": "kick" if WSAD else "kick2",
		"left": "left" if WSAD else "left2",
		"right": "right" if WSAD else "right2",
		}

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed(player_controls["jump"]) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis(player_controls["left"], player_controls["right"])
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	handle_kick_action(delta)
	move_and_slide()
	apply_collision_impulse()
	move_and_collide(Vector2.ZERO)

func handle_kick_action(delta):
	var foot = $"Foot"
	if Input.is_action_pressed(player_controls["kick"]) and foot.rotation > FOOT_MAX_ROTATION:
		foot.rotation -= FOOT_KICK_SPEED * delta
	elif foot.rotation < 0 and not Input.is_action_pressed(player_controls["kick"]):
		foot.rotation += FOOT_RESET_SPEED * delta
	for i in get_slide_collision_count():
		var slide_collision = get_slide_collision(i)
		if slide_collision.get_collider() is RigidBody2D:
			var collider = slide_collision.get_collider()
			var collision_normal = slide_collision.get_normal()
			collider.apply_central_impulse(-collision_normal * KICK_FORCE)

func apply_collision_impulse():
	for i in get_slide_collision_count():
		var slide_collision = get_slide_collision(i)
		if slide_collision.get_collider() is RigidBody2D:
			var collider = slide_collision.get_collider()
			var collision_normal = slide_collision.get_normal()
			if not is_on_floor() and velocity.y < 0:
				collider.apply_central_impulse(-collision_normal * (HEADER_FORCE + abs(velocity.y)))
			else:
				collider.apply_central_impulse(-collision_normal * PUSH_FORCE)
	
