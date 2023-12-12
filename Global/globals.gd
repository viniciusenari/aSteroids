extends Node

signal health_change
signal xp_change
signal level_up

var player_position: Vector2
var player_level: int = 1
var current_level_threshold: float = 50

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func reset_variables():
	player_health = 100
	player_xp = 0
	player_level = 1
	player_damage = 10
	laser_amount = 1
	pierce = 1
	laser_cooldown = 1
	

var player_health: float = 100:
	set(value):
		player_health = max(0, value)
		if player_health <= 0:
			get_tree().change_scene_to_file("res://Scenes/Menus/game_over_screen.tscn")
		health_change.emit()

var player_xp: float = 0:
	set(value):
		player_xp = value
		while player_xp >= current_level_threshold:
			player_xp -= current_level_threshold
			player_level += 1
			current_level_threshold = 50 * (1.25 ** (player_level - 1))
			level_up.emit()
		xp_change.emit()


signal laser_amount_increase
signal laser_cooldown_change
signal pierce_change

var player_damage: int = 10
var laser_amount: int = 1:
	set(value):
		laser_amount = value
		laser_amount_increase.emit()
		
var pierce: int = 1:
	set(value):
		pierce = value
		pierce_change.emit()
		
var laser_cooldown: float = 1:
	set(value):
		laser_cooldown = value
		laser_cooldown_change.emit()
