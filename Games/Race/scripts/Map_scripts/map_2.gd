extends Control

const checkPointsOfMap: int = 10
var EndingRace: PackedScene = preload("res://Games/Race/scenes/UI/EndingRace.tscn")
@export var PlayerScene: PackedScene
@onready var endingscene = EndingRace.instantiate()

func _ready() -> void:
	Globals.LapsNeedToBeMade = checkPointsOfMap
	Globals.LapTimes = []
	Globals.RaceTime = 0
	Globals.can_end.connect(EndRace)
	if !Globals.SinglePlayer:
		var index = 0
		for i in Multiplayer.Players:
			var currentPlayer = PlayerScene.instantiate()
			currentPlayer.name = str(Multiplayer.Players[i].id)
			add_child(currentPlayer)
			for spawn in $SpawnPoints.get_children():
				if spawn.name == str(index):
					currentPlayer.global_position = spawn.global_position
					currentPlayer.rotation_degrees = -90
			index += 1
	else:
		var currentPlayer = PlayerScene.instantiate()
		add_child(currentPlayer)
		currentPlayer.global_position = $"SpawnPoints/0".global_position
		currentPlayer.rotation_degrees = -90
	
func EndRace():
	add_child(endingscene)
	Globals.race_ended.emit()

func _on_track_1_body_entered(body: Node2D) -> void:
	if body.has_method("on_track"):
		body.on_track()


func _on_track_1_body_exited(body: Node2D) -> void:
	if body.has_method("slow_down"):
		body.slow_down()

func _on_track_2_body_entered(body: Node2D) -> void:
	if body.has_method("slow_down"):
		body.slow_down()


func _on_track_2_body_exited(body: Node2D) -> void:
	if body.has_method("on_track"):
		body.on_track()
