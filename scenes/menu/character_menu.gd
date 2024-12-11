extends Control

var game_time = 90
@onready var time_label = $HBoxContainer2/Time
@onready var character_sprites = [] 
const SPRITES_PATH = "res://assets/sprites/characters/"
@onready var player1_sprite = $VBoxContainer/CenterContainer/HBoxContainer/Player1
@onready var player2_sprite = $VBoxContainer2/CenterContainer/HBoxContainer/Player2
var player1_choice = 0
var player2_choice = 1

func _ready():
	GameData.bonus = false
	var dir = DirAccess.open(SPRITES_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				var sprite_path = SPRITES_PATH + file_name
				var texture = load(sprite_path)  # Load the texture
				character_sprites.append(texture)
			file_name = dir.get_next()
	dir.list_dir_end()
	player1_sprite.texture = character_sprites[player1_choice]
	player2_sprite.texture = character_sprites[player2_choice]
	SoundFx.button_sounds(self)
	update_time_label()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_play_pressed():
	GameData.game_time = game_time
	GameData.player1_sprite = character_sprites[player1_choice]
	GameData.player2_sprite = character_sprites[player2_choice]
	SoundFx.stop_track(0)
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")
	


func _on_player1_sprite_right():
	player1_choice = (player1_choice + 1) % character_sprites.size()  # Increment and wrap
	player1_sprite.texture = character_sprites[player1_choice]

func _on_player1_sprite_left():
	player1_choice = (player1_choice - 1 + character_sprites.size()) % character_sprites.size()
	player1_sprite.texture = character_sprites[player1_choice]

func _on_player2_sprite_left():
	player2_choice = (player2_choice + 1) % character_sprites.size()  # Increment and wrap
	player2_sprite.texture = character_sprites[player2_choice]


func _on_player2_sprite_right():
	player2_choice = (player2_choice - 1 + character_sprites.size()) % character_sprites.size()
	player2_sprite.texture = character_sprites[player2_choice]

func update_time_label():
	var minutes = int(game_time / 60)
	var seconds = int(game_time) % 60
	var time_str = "%02d:%02d" % [minutes, seconds]
	time_label.text = str(time_str)

func _on_minus_pressed():
	if game_time > 30:
		game_time -= 30
	update_time_label()
		


func _on_plus_pressed():
	if game_time <= 180:
		game_time += 30
	update_time_label()


func _on_bonus_toggled(toggled_on):
	GameData.bonus = toggled_on
