extends Marker2D

@export var enemies_scenes: Array[PackedScene]
@export var x_range: int
@export var y_range: int

signal spawn(x_range, y_range, enemies_scenes)

var can_spawn = true
	
func _process(delta):
	if can_spawn:
		spawn.emit(x_range, y_range, enemies_scenes)
		can_spawn = false
		$SpawnTimer.start()
	
	
func _on_spawn_timer_timeout():
	can_spawn = true
