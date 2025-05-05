extends Control
@onready var Mapimage: TextureRect = $MarginContainer/VBoxContainer/TextureRect
const MAP_1P = preload("res://Assets/Racing_AssetPack_Personal/map1p.png")
const MAP_2P = preload("res://Assets/Racing_AssetPack_Personal/map2p.png")
const MAP_3P = preload("res://Assets/Racing_AssetPack_Personal/map3p.png")
var mapChoice = 1
@onready var start: Button = $MarginContainer/VBoxContainer/START


func _ready() -> void:
	if multiplayer.get_unique_id() != 1:
		start.queue_free()

func _on_tab_bar_tab_changed(tab: int) -> void:
	if multiplayer.get_unique_id() == 1:
		rpc("ChangeMap", tab)

@rpc("authority", "call_local")
func ChangeMap(tab: int):
	if tab == 0:
		Mapimage.texture = MAP_1P
		mapChoice = 1
	if tab == 1:
		Mapimage.texture = MAP_2P
		mapChoice = 2
	if tab == 2:
		Mapimage.texture = MAP_3P
		mapChoice = 3


func _on_start_pressed() -> void:
	if multiplayer.get_unique_id() == 1:
		StartGame.rpc()

@rpc("any_peer", "call_local")
func StartGame():
	var scene = "res://Games/Race/scenes/Maps/map_" + str(mapChoice) + ".tscn"
	Transition.play_animation(scene)


func _on_back_pressed() -> void:
	Transition.play_animation("res://UI/Main_menu.tscn")
