extends CanvasLayer

class_name LevelUp

enum PowerUp {
	LASER_AMOUNT,
	DAMAGE,
	COOLDOWN,
	PIERCE
}

var available_power_ups = [
	PowerUp.LASER_AMOUNT,
	PowerUp.DAMAGE,
	PowerUp.COOLDOWN,
	PowerUp.PIERCE
]


@export var power_up_card: PackedScene
var card_count: int = 3

func _ready():
	for i in range(card_count):
		var card = power_up_card.instantiate()
		%CardsContainer.add_child(card)
		
		var random_index = randi() % available_power_ups.size()
		var selected_item = available_power_ups[random_index]
		available_power_ups.remove_at(random_index)
		
		card.card_type = selected_item
		card.connect("button_pressed", _on_power_up_button_pressed)
	
func _on_power_up_button_pressed(card_type):
	if card_type == LevelUp.PowerUp.LASER_AMOUNT:
		Globals.laser_amount += 1
	elif card_type == LevelUp.PowerUp.DAMAGE:
		Globals.player_damage += 1
	elif card_type == LevelUp.PowerUp.COOLDOWN:
		Globals.laser_cooldown = Globals.laser_cooldown - 0.1 * Globals.laser_cooldown
	elif card_type == LevelUp.PowerUp.PIERCE:
		Globals.pierce += 1
	
	GameManager.level_up_paused = false
	queue_free()
