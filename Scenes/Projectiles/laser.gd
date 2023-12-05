extends Area2D

const SPEED: int = 1000
var direction: Vector2 = Vector2.RIGHT
var pierce: int

func _ready():
	pierce = Globals.pierce
	$LaserLifetimeTimer.start()

func _process(delta):
	position += direction * SPEED * delta


func _on_laser_lifetime_timer_timeout():
	queue_free()


func _on_area_entered(_area):
	pierce -= 1
	if pierce == 0:
		queue_free()
