extends Marker2D

@export var enemies_scenes: Array[PackedScene]
@export var x_range: int
@export var y_range: int

signal spawn(x_range, y_range, enemies_scenes, spawner_position)

var can_spawn = true
var initial_position: Vector2

func _ready():
	initial_position = position
	
func _process(_delta):
	position = initial_position + Globals.player_position
	if can_spawn:
		spawn.emit(x_range, y_range, enemies_scenes, global_position)
		can_spawn = false
		$SpawnTimer.start()
	
	
func _on_spawn_timer_timeout():
	can_spawn = true
