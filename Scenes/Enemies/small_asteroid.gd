extends RigidBody2D

signal drop_items(pos)

var speed: int
var direction: Vector2

@export var damage: int = 10
@export var health: int = 10

func _ready():
	speed = randi_range(100, 200)
	angular_velocity = randf_range(-2, 2)
	

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	

func hit(area):
	if area.get_parent().is_in_group("Asteroids"):
		pass
		die("collision")
	else:
		health -= Globals.player_damage
		if health <= 0:
			die("player")

func die(death_cause: String):
	if death_cause == "collision":
		queue_free()
	elif death_cause == "player":
		drop_items.emit(position)
		queue_free()

func _on_hurtbox_area_entered(area):
	if area != $Hitbox:
		hit(area)
