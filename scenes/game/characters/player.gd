extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
const PUSH_FORCE = 150.0
const FOOT_MAX_ROTATION = -2.5
const FOOT_RESET_SPEED = 10.0
const FOOT_KICK_SPEED = 20.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var WSAD = false
var player_controls
func _ready():
	if WSAD:
		player_controls = {
		"jump": "jump2",
		"kick": "kick2",
		"left": "left2",
		"right": "right2",
		}
	else:
		player_controls = {
		"jump": "jump",
		"kick": "kick",
		"left": "left",
		"right": "right",
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
	
func handle_kick_action(delta):
	var foot = $"Foot"
	if Input.is_action_pressed(player_controls["kick"]) and foot.rotation > FOOT_MAX_ROTATION:
		foot.rotation -= FOOT_KICK_SPEED * delta
	elif foot.rotation < 0 and not Input.is_action_pressed(player_controls["kick"]):
		foot.rotation += FOOT_RESET_SPEED * delta
	
func apply_collision_impulse():
	for i in get_slide_collision_count():
		var slide_collision = get_slide_collision(i)
		if slide_collision.get_collider() is RigidBody2D:
			var collider = slide_collision.get_collider()
			var collision_normal = slide_collision.get_normal()
			collider.apply_central_impulse(-collision_normal * PUSH_FORCE)
