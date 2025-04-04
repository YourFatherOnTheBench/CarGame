extends Control

var peer = ENetMultiplayerPeer.new()

func _on_desset_pressed() -> void:
	Globals.Stop_moving = true
	Globals.race_started = false
	Transition.play_animation("res://Games/Race/scenes/map.tscn")


func _on_grassland_pressed() -> void:
	Globals.Stop_moving = true
	Globals.race_started = false
	Transition.play_animation("res://Games/Race/scenes/map_2.tscn")


func _on_snow_pressed() -> void:
	Globals.Stop_moving = true
	Globals.race_started = false
	Transition.play_animation("res://Games/Race/scenes/map_3.tscn")
