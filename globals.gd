extends Node

var player_position: Vector2

var player_damage: int = 10
var pierce: int = 1

var player_health: int = 100:
	set(value):
		player_health -= 10
		print(player_health)
	
