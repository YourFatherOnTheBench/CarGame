extends Panel


@onready var name_label: Label = $HBoxContainer2/Label
@onready var time_label: Label = $HBoxContainer2/time
@onready var laps_label: Label = $HBoxContainer2/laps
@onready var timer: Timer = $Timer


var laps_made = 1
var race_laps = 5
var checkpoints_made: int = 0
var time: float = 0
var lapTime: float
var showtimer: bool = true




func _ready() -> void:
	Globals.lap_made.connect(Did_Lap)


func _process(delta: float) -> void:
	if Globals.race_started and !Globals.Stop_moving:
		Globals.Players[self.name]["time"] += delta
		if Globals.Players[self.name].LapsMade > 5:
			Globals.can_end.emit()
			
	Update_UI()

func Did_Lap(body):
	UpdatePlayers(body)


func UpdatePlayers(body):
	if str(body.name) != self.name:
		return
	if Globals.Players[self.name].CheckpointsMade >= Globals.LapsNeedToBeMade:
		Globals.Players[self.name].CheckpointsMade = 0
		showtimer = false 

		timer.start()
		Globals.Players[self.name].LapsMade += 1
		Globals.Players[self.name]["Laps"].append(snapped(Globals.Players[self.name].time, 0.01))
		Globals.Players[self.name].time = 0
		print(Globals.Players)
		Update_UI()
func Update_UI():

	if showtimer and Globals.Players[self.name].LapsMade < 6:
		time_label.text = " %.2f" % Globals.Players[self.name].time + "s"
	name_label.text = Globals.Players[self.name].name
	laps_label.text = str(Globals.Players[self.name].LapsMade) + "/5"


func _on_timer_timeout() -> void:
	showtimer = true
