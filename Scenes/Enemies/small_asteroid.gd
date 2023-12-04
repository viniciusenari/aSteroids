extends RigidBody2D

var speed: int
var direction: Vector2

func _ready():
	speed = randi_range(100, 200)
	#angular_velocity = randf_range(360, 720)
	
func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	var contacts = get_colliding_bodies()
	var contacts_number = get_contact_count()
	if contacts_number > 0:
		for body in contacts:
			if 'hit' in body:
				body.hit()
			if body.is_in_group("Player"):
				hit("player")

func hit(killer = null):
	if killer == "player":
		print("player killed asteroid")
	else:
		print("Asteroid collided with another asteroid")
	queue_free()
