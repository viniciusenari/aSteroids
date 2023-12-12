extends Node

signal toggle_game_paused(is_paused: bool)

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

var player_paused: bool = false:
	set(value):
		player_paused = value
		get_tree().paused = player_paused or level_up_paused
		toggle_game_paused.emit(player_paused)
		
var level_up_paused: bool = false:
	set(value):
		level_up_paused = value
		get_tree().paused = player_paused or level_up_paused


func _input(event: InputEvent):
	if (event.is_action_pressed("ui_cancel")):
		if not get_tree().paused:
			player_paused = true
		elif get_tree().paused and not level_up_paused:
			player_paused = false
		elif level_up_paused:
			player_paused = !player_paused
		
