extends Control


func _on_play_again_button_pressed():
	Globals.reset_variables()
	get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
