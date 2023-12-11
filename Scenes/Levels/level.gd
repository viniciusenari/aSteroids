extends Node2D

var laser_scene = preload("res://Scenes/Projectiles/laser.tscn")
var item_scene = preload("res://Scenes/Items/item.tscn")

func _ready():
	for spawner in get_tree().get_nodes_in_group("Spawner"):
		spawner.connect("spawn", _on_spawner_spawn)

func _on_player_shot_fired(positions, laser_direction):
	for pos: Vector2 in positions:
		var laser: Area2D = laser_scene.instantiate()
		laser.position = pos
		laser.rotation_degrees = rad_to_deg(laser_direction.angle())
		laser.direction = laser_direction
		$Projectiles.add_child(laser)


func _on_spawner_spawn(x_range, y_range, enemies_scenes, spawner_position):
	var enemy = enemies_scenes[randi() % len(enemies_scenes)].instantiate()
	$Enemies.add_child(enemy)
	
	enemy.connect("drop_items", _on_enemy_death)
	
	var position_offset: Vector2 = Vector2(randi_range(-x_range, x_range), randi_range(-y_range, y_range))
	var direction: Vector2 = (Globals.player_position - (spawner_position + position_offset)).normalized()
	enemy.global_position = spawner_position + position_offset
	enemy.direction = direction

func _on_enemy_death(pos):
	var item = item_scene.instantiate()
	item.position = pos
	$Items.call_deferred("add_child", item)
