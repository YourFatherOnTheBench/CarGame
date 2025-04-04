extends Control
@onready var Mapimage: TextureRect = $MarginContainer/VBoxContainer/TextureRect
const MAP_1P = preload("res://Assets/Racing_AssetPack_Personal/map1p.png")
const MAP_2P = preload("res://Assets/Racing_AssetPack_Personal/map2p.png")
const MAP_3P = preload("res://Assets/Racing_AssetPack_Personal/map3p.png")
var mapChoice = 1

func _on_tab_bar_tab_changed(tab: int) -> void:
	if tab == 0:
		Mapimage.texture = MAP_1P
		mapChoice = 1
	if tab == 1:
		Mapimage.texture = MAP_2P
		mapChoice = 2
	if tab == 2:
		Mapimage.texture = MAP_3P
		mapChoice = 3
	


func _on_join_pressed() -> void:
	Multiplayer.join()

func _on_host_pressed() -> void:
	Multiplayer.host()
	

func _on_start_pressed() -> void:
	StartGame.rpc()

@rpc("any_peer", "call_local")
func StartGame():
	var scene = "res://Games/Race/scenes/Maps/map_" + str(mapChoice) + ".tscn"
	Transition.play_animation(scene)
