extends Area2D

var rotation_speed: float = randf_range(-1,1)
var available_types = ['health', 'xp', 'xp', 'xp', 'xp', 'xp', 'xp', 'xp', 'xp']
var type = available_types[randi() % len(available_types)]

func _ready():
	if type == "health":
		$Polygon2D.modulate = Color(0.5, 1, 0.5)
	elif type == "xp":
		$Polygon2D.modulate = Color(0.8, 0.8, 0)

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	var destroy: bool = body.add_item(type)
	if destroy:
		queue_free()
