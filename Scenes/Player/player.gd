extends CharacterBody2D

const SPEED: int = 300
var can_shoot: bool = true
signal shot_fired(positions)

@export var laser_amount: int = 1
var laser_distance: int = 5


func _process(_delta):
	Globals.player_position = global_position
	
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	look_at(get_global_mouse_position())
	
	var laser_direction: Vector2 = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary_action") and can_shoot:
		shoot(laser_direction)
	
func shoot(laser_direction):
	var positions = calculate_laser_positions()
	shot_fired.emit(positions, laser_direction)
	can_shoot = false
	$Timers/ShootTimer.start()

func calculate_laser_positions():
	var laser_marker : Marker2D = $LaserPosition
	var positions = []
	
	var midpoint: float = ((laser_amount - 1) / 2.0) * laser_distance
	var initial_pos: Vector2 = laser_marker.position
	for i: int in range(0, laser_amount):
		var offset: int = i * laser_distance
		laser_marker.position += Vector2(0, offset - midpoint)
		positions.append(laser_marker.global_position)
		laser_marker.position = initial_pos
	
	return positions

func _on_shoot_timer_timeout():
	can_shoot = true
