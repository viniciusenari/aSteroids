extends Node

signal health_change
signal xp_change

var player_position: Vector2

var player_damage: int = 10
var pierce: int = 1

var player_health: float = 100:
	set(value):
		player_health = max(0, value)
		health_change.emit()

var player_xp: float = 0:
	set(value):
		player_xp = value
		xp_change.emit()

