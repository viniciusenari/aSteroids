extends CanvasLayer

func _ready():
	hide()
	GameManager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)

func _on_game_manager_toggle_game_paused(is_paused: bool):
	if is_paused:
		show()
	else:
		hide()


func _on_resume_button_pressed():
	GameManager.player_paused = false


func _on_quit_game_button_pressed():
	get_tree().quit()
