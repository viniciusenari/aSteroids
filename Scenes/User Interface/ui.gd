extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthBar
@onready var xp_bar: ProgressBar = $MarginContainer/VBoxContainer/XPBar

func _ready():
	Globals.connect("health_change", update_health_bar)
	Globals.connect("xp_change", update_xp_bar)
	update_health_bar()
	update_xp_bar()

func update_health_bar():
	health_bar.value = Globals.player_health

func update_xp_bar():
	xp_bar.value = Globals.player_xp
