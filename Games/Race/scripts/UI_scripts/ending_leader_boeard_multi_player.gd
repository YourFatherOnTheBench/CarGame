extends CanvasLayer

@onready var container: VBoxContainer = $MarginContainer/Panel/VBoxContainer
@onready var Player_data_scene: PackedScene = preload("res://Games/Race/scenes/UI/player_result_label.tscn")

var player_ids = []
var place: int = 1
var i: int = 0
func _ready() -> void:
	player_ids = get_ids()
	Globals.race_ended.connect(RaceEnding)



func RaceEnding():
	print("Race Ended")
	print(player_ids)
	print(Multiplayer.Players)
	$AnimationPlayer.play("LeaderBoard")
	for player in Multiplayer.Players:
		if Multiplayer.Players[player]["LapsMade"] > 5:
			var player_data = Player_data_scene.instantiate()
			player_data.id = player_ids[i]
			player_data.place = str(place)
			container.add_child(player_data)
			place += 1
		i += 1
	Globals.Stop_moving = true



func get_ids():
	var sum = 0
	var times = {}


	for i in Multiplayer.Players:
		for j in Multiplayer.Players[i]["Laps"]:
			sum += j
		times[i] = sum
		sum = 0
	var sorted_ids = times.keys()
	sorted_ids.sort_custom(func(a,b):
		if Multiplayer.Players[a]["LapsMade"] > 5:
			return times[a] < times[b]
		)
		
	return sorted_ids
