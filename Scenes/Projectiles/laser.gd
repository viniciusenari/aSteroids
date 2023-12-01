extends Area2D

const SPEED: int = 1000
var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	position += direction * SPEED * delta


func _on_body_entered(body):
	queue_free()
	body.queue_free()
	
