extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
const PUSH_FORCE = 150.0
const HEADER_FORCE = 200.0
const FOOT_MAX_ROTATION = -1.5
const KICK_FORCE = Vector2(500.0, -100.0)
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
var landing_sfx = false

func _ready():
	if WSAD:
		$Sprite2D.texture = GameData.player1_sprite
	else:
		$Sprite2D.texture = GameData.player2_sprite
	if GameData.bonus:
		$Foot/CollisionShape2D/Sprite2D.texture = load("res://assets/sprites/boots/merc.png")

func _physics_process(delta):
	if not is_on_floor():
		landing_sfx = true
		velocity.y += gravity * delta
	if Input.is_action_just_pressed(player_controls["jump"]) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$PlayerSFX/Jump.play()
	var direction = Input.get_axis(player_controls["left"], player_controls["right"])
	
	if landing_sfx and is_on_floor():
		$PlayerSFX/Landing.play()
		landing_sfx = false
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	handle_kick_action(delta)
	move_and_slide()
	apply_collision_impulse()
	move_and_collide(Vector2.ZERO)

func handle_kick_action(delta):
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
			if not $PlayerSFX/Header.playing:
				$PlayerSFX/Header.play()
			if not is_on_floor() and velocity.y < 0:
				collider.apply_central_impulse(-collision_normal * (HEADER_FORCE + abs(velocity.y)))
			else:
				collider.apply_central_impulse(-collision_normal * PUSH_FORCE)
	
func _on_ball_entered(body):
	if body is RigidBody2D:
		body.apply_central_impulse(KICK_FORCE)
		if not $PlayerSFX/Kick.playing and not $PlayerSFX/Header.playing:
			$PlayerSFX/Kick.play()
