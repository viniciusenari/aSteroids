extends Area2D

var speed: int
var direction: Vector2

func _ready():
	speed = randi_range(100, 200)

func _process(delta):
	position += direction * speed * delta

func hit():
	queue_free()
	print("Asteroid was hit")

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
