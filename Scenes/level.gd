extends Node2D

var laser_scene = preload("res://Scenes/laser.tscn")

func _on_player_shot_fired(positions, laser_direction):
	for pos: Vector2 in positions:
		var laser : Area2D = laser_scene.instantiate()
		laser.position = pos
		laser.rotation_degrees = rad_to_deg(laser_direction.angle())
		laser.direction = laser_direction
		$Projectiles.add_child(laser)
