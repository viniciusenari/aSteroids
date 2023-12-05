extends RigidBody2D

var speed: int
var direction: Vector2
@export var health = 10;

func _ready():
	speed = randi_range(100, 200)
	#angular_velocity = randf_range(360, 720)
	

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	

func hit(area):
	if area.get_parent().is_in_group("Asteroids"):
		pass
		# Asteroid collided with another asteroid"
	else:
		health -= Globals.player_damage
	
	if health == 0:
		queue_free()



func _on_hurtbox_area_entered(area):
	if area != $Hitbox:
		hit(area)
