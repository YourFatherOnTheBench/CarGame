extends Control

const checkpointsofMap: int = 7
var EndingRace: PackedScene = preload("res://Games/Race/scenes/UI/EndingRace.tscn")
@onready var endingscene = EndingRace.instantiate()
@export var PlayerScene: PackedScene
func _ready() -> void:
	Globals.LapsNeedToBeMade = checkpointsofMap
	Globals.LapTimes = []
	Globals.RaceTime = 0
	Globals.can_end.connect(EndRace)
	var index = 0
	for i in Multiplayer.Players:
		var currentPlayer = PlayerScene.instantiate()
		currentPlayer.name = str(Multiplayer.Players[i].id)
		add_child(currentPlayer)
		for spawn in $SpawnPoints.get_children():
			if spawn.name == str(index):
				currentPlayer.global_position = spawn.global_position
		index += 1
	
func EndRace():
	add_child(endingscene)
	Globals.race_ended.emit()


func _on_track_1_body_exited(body: Node2D) -> void:
	if body.has_method("slow_down"):
		body.slow_down()


func _on_track_2_body_entered(body: Node2D) -> void:
	if body.has_method("slow_down"):
		body.slow_down()


func _on_track_1_body_entered(body: Node2D) -> void:
	if body.has_method("on_track"):
		body.on_track()


func _on_track_2_body_exited(body: Node2D) -> void:
	if body.has_method("on_track"):
		body.on_track()


	
