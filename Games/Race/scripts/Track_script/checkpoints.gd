extends Path2D

@onready var checkpoint_made: int = 7
var i = 0

func _ready() -> void:
	for child in get_children():
		child.connect("body_entered",  Callable(self, "add_checkpoint").bind(i))
		i += 1
func add_checkpoint(body: Node, index: int) -> void:
	if Globals.SinglePlayer:
		if index == checkpoint_made:
			checkpoint_made += 1
	else:
		var player_id = int(body.name)
		if Multiplayer.Players[player_id]["CheckpointsMade"] == index:
			Multiplayer.Players[player_id]["CheckpointsMade"] += 1

func _on_start_line_body_entered(body: Node2D) -> void:
	if Globals.SinglePlayer:
		if checkpoint_made >= Globals.LapsNeedToBeMade:
			print(multiplayer.get_unique_id())
			checkpoint_made = 0
			Globals.race_started = true
			Globals.lap_made.emit(body)
	else:
		var player_id = int(body.name)
		if Multiplayer.Players[player_id]["CheckpointsMade"] >= Globals.LapsNeedToBeMade:
			Globals.sync_data.emit(player_id, Multiplayer.Players[player_id]["time"])
			Multiplayer.Players[player_id]["CheckpointsMade"] = 0
			Globals.lap_made.emit(body)
		
