extends CanvasLayer


@onready var laps_label: Label = $container/MarginContainer/Vbox/Border/HBoxContainer/laps
@onready var time_label: Label = $container/MarginContainer/Vbox/Border/HBoxContainer/time
@onready var timer: Timer = $Timer


var laps_made = 0
var race_laps = 5
var checkpoints_made: int = 0
var time: float = 0
var lapTime: float
var showtimer: bool = true



func _ready() -> void:
	Globals.lap_made.connect(Did_Lap)

func _process(delta: float) -> void:
	if Globals.race_started and !Globals.Stop_moving:
		for i in Multiplayer.Players:
			Multiplayer.Players[i]["time"] += delta
			
	print(Multiplayer.Players )
		
	
	

func Did_Lap():
	pass
	
@rpc("any_peer", "call_local")
func Update_UI():
	pass
