extends Control

var peer = ENetMultiplayerPeer.new()

func _on_desset_pressed() -> void:
	Globals.Stop_moving = true
	Globals.race_started = false
	Transition.play_animation("res://Games/Race/scenes/Maps/map_1.tscn")


func _on_grassland_pressed() -> void:
	Globals.Stop_moving = true
	Globals.race_started = false
	Transition.play_animation("res://Games/Race/scenes/Maps/map_2.tscn")


func _on_snow_pressed() -> void:
	Globals.Stop_moving = true
	Globals.race_started = false
	Transition.play_animation("res://Games/Race/scenes/Maps/map_3.tscn")


func _on_button_pressed() -> void:
	Transition.play_animation("res://UI/Main_menu.tscn")
