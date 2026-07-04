extends Control

const checkpointsofMap: int = 7
@onready var EndingRace: PackedScene = preload("res://Games/Race/scenes/UI/EndingRace.tscn")
@onready var EndingMultiplayerScene: PackedScene = preload("res://EndingLeaderBoeardMultiPlayer.tscn")
@onready var endingscene = EndingRace.instantiate()
@onready var EndingMultiplayer = EndingMultiplayerScene.instantiate()

@onready var Player1Scene: PackedScene = preload("res://Games/Race/scenes/Player.tscn")
@onready var Player2Scene: PackedScene = preload("res://Games/Race/scenes/Players/PLAYER2.tscn")
@onready var camera: Camera2D = $Camera2D



func _ready() -> void:
	Globals.restart()
	Globals.LapsNeedToBeMade = checkpointsofMap
	Globals.LapTimes = []
	Globals.RaceTime = 0
	Globals.can_end.connect(EndRace)
	if !Globals.SinglePlayer:
		var player1 = Player1Scene.instantiate()
		var player2 = Player2Scene.instantiate()
		player1.global_position = $"SpawnPoints/0".global_position
		player1.name = "1"
		player2.name = "2"
		player2.global_position = $"SpawnPoints/1".global_position
		add_child(player1)
		add_child(player2)
		for p in get_tree().get_nodes_in_group("Players"):
			camera.add_player(p)
	else:
		var currentPlayer = Player1Scene.instantiate()
		add_child(currentPlayer)
		currentPlayer.global_position = $"SpawnPoints/0".global_position
		for p in get_tree().get_nodes_in_group("Players"):
			camera.add_player(p)
		

	
func EndRace():
	if Globals.SinglePlayer:
		add_child(endingscene)
		Globals.race_ended.emit()
	else:
		if Globals.Players["1"].LapsMade > 5 and Globals.Players["2"].LapsMade > 5:
			add_child(EndingMultiplayer)
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


	
