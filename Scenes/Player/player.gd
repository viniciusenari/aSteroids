extends CharacterBody2D

const SPEED: int = 350
var can_shoot: bool = true
signal shot_fired(positions)

var laser_amount: int 
var laser_distance: int = 5
var laser_direction: Vector2

func _ready():
	Globals.connect("laser_amount_increase", _on_laser_amount_increase)
	Globals.connect("laser_cooldown_change", _on_laser_cooldown_change)
	laser_amount = Globals.laser_amount

func _process(_delta):
	Globals.player_position = global_position
	
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
	look_at(get_global_mouse_position())
	
	laser_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_pressed("primary_action") and can_shoot:
		shoot()

func shoot():
	var positions = calculate_laser_positions()
	shot_fired.emit(positions, laser_direction)
	can_shoot = false
	$Timers/ShootTimer.start()

func calculate_laser_positions() -> Array:
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

func hit(enemy):
	Globals.player_health -= enemy.damage

func _on_hurt_box_area_entered(area):
	hit(area.get_parent())

func add_item(item: String) -> bool:
	if item == "health" and Globals.player_health < 100:
		Globals.player_health += 10
		return true
	elif item == "xp":
		Globals.player_xp += 10
		return true
	
	return false


func _on_laser_amount_increase() -> void:
	laser_amount = Globals.laser_amount

func _on_laser_cooldown_change() -> void:
	$Timers/ShootTimer.set_wait_time(Globals.laser_cooldown)
