extends VBoxContainer

signal button_pressed(card_type)

var power_ups = {
	LevelUp.PowerUp.LASER_AMOUNT : {
		"text" : "Laser Amount +1"
	},
	LevelUp.PowerUp.DAMAGE : {
		"text" : "Increase Damage"
	},
	LevelUp.PowerUp.COOLDOWN : {
		"text" : "Decrease Cooldown"
	},
	LevelUp.PowerUp.PIERCE : {
		"text" : "Pierce +1"
	}
}

var card_type: LevelUp.PowerUp:
	set(value):
		card_type = value
		$SelectPowerUpButton.text = power_ups[card_type]["text"]


func _on_select_power_up_button_pressed():
	button_pressed.emit(card_type)
