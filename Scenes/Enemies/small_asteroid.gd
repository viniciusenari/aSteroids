extends RigidBody2D

const SPEED: int = 300
var direction: Vector2

func _process(delta):
	move_and_collide(direction * SPEED * delta)
