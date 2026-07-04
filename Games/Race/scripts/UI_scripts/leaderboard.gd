extends CanvasLayer

@onready var timeLabel: Label = $Control/marginConainer/Panel/ColorRect/Label
@onready var vbox: VBoxContainer = $Control/MarginContainer/Vbox
var MultiPlater_Player_leaderboard_scene: PackedScene = preload("res://Games/Race/scenes/UI/MultiPlayerLeaderBoard.tscn")
var CarLeaderBoardScene : PackedScene = preload("res://Games/Race/scenes/UI/CarsLeaderBoard.tscn")
var time: float = 0.00

func _ready() -> void:
	if !Globals.SinglePlayer:
		for i in Globals.Players:
			var MultiPlater_Player_leaderboard = MultiPlater_Player_leaderboard_scene.instantiate()
			MultiPlater_Player_leaderboard.name = str(Globals.Players[i]["id"])
			vbox.add_child(MultiPlater_Player_leaderboard)
			# add name to the multiplayer leader board of multiplayer.players[i][id]
			
			
	else:
		var CarLeaderBoard = CarLeaderBoardScene.instantiate()
		vbox.add_child(CarLeaderBoard)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.race_started and !Globals.Stop_moving:
		time += delta
		timeLabel.text = " Time:   %.2f" % time + "s"
