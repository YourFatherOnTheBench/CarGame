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
	print(self.name)
	if multiplayer.get_unique_id() == int(self.name):
		Globals.lap_made.connect(Did_Lap)
		print("connected ")


func _process(delta: float) -> void:
	if Globals.race_started and !Globals.Stop_moving:
		if self.name == str(Multiplayer.Players[int(self.name)].id):
			Multiplayer.Players[int(self.name)]["time"] += delta
			Multiplayer.check_laps(int(self.name))
			
	Update_UI()

func Did_Lap(body):
	UpdatePlayers(body)


func UpdatePlayers(body):
	if multiplayer.get_unique_id() == int(body.name):
		showtimer = false

		timer.start()
		#Multiplayer.Players[int(body.name)]["LapsMade"] += 1
		#Multiplayer.Players[int(body.name)]["Laps"].append(snapped(Multiplayer.Players[int(body.name)].time, 0.01))
	#	Multiplayer.Players[int(body.name)]["time"] = 0
		Update_UI()
func Update_UI():

	if showtimer:
		time_label.text = " %.2f" % Multiplayer.Players[int(self.name)].time + "s"
	name_label.text = Multiplayer.Players[int(self.name)].name
	laps_label.text = str(Multiplayer.Players[int(self.name)].LapsMade) + "/5"


func _on_timer_timeout() -> void:
	showtimer = true
