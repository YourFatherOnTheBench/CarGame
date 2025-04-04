extends CanvasLayer


@onready var timeLabel: Label = $Control/MarginContainer/Vbox/Panel2/HBoxContainer/time
@onready var laps: Label = $Control/MarginContainer/Vbox/Panel2/HBoxContainer/laps
@onready var timer: Timer = $Timer

var laps_made = 0
var race_laps = 5
var checkpoints_made: int = 0
var time: float = 0
var lapTime: float
var showtimer: bool = true



func _ready() -> void:
	Globals.connect("lap_made",Did_lap)


func _process(delta: float) -> void:
	if Globals.race_started and !Globals.Stop_moving:
		time += delta
		if showtimer:
			timeLabel.text = "%.2f" % time + "s"
		
func Did_lap():
	Globals.LapTimes.append(snapped(time, 0.01))
	print(Globals.LapTimes)
	if laps_made == 0:
		laps_made += 1
		laps.text = str(laps_made) + "/5"
	else:
		update_ui()

	
func update_ui():
	showtimer = false
	laps_made += 1
	time = 0

	timer.start()
	if laps_made >= race_laps + 1:
		Globals.can_end.emit()
	else:
		laps.text = str(laps_made) + "/5"

	
	


func _on_timer_timeout() -> void:
	showtimer = true
