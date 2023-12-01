extends Area2D

func _process(_delta):
	position = Globals.player_position

func _on_body_exited(body):
	body.queue_free()


func _on_area_exited(area):
	area.queue_free()
