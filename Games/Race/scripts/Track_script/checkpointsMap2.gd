extends Path2D
@onready var checkpoint_made: int = 10
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
		var player_id = body.name
		print(player_id)
		if Globals.Players[player_id]["CheckpointsMade"] == index:
			Globals.Players[player_id]["CheckpointsMade"] += 1
	print(Globals.Players)
	
func _on_finish_line_body_entered(body: Node2D) -> void:
	if Globals.SinglePlayer:
		if checkpoint_made >= Globals.LapsNeedToBeMade:
			checkpoint_made = 0
			Globals.lap_made.emit(body)
			Globals.race_started = true
	else:
		var player_id = body.name
		if Globals.Players[player_id]["CheckpointsMade"] >= Globals.LapsNeedToBeMade:
			Globals.lap_made.emit(body)
			print("didlap")
