extends CanvasLayer
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var time_1: Label = $MarginContainer/Panel/VBoxContainer/Results1/Time1
@onready var time_2: Label = $MarginContainer/Panel/VBoxContainer/Results2/Time2
@onready var time_3: Label = $MarginContainer/Panel/VBoxContainer/Results3/Time3
@onready var time_4: Label = $MarginContainer/Panel/VBoxContainer/Results4/Time4
@onready var time_5: Label = $MarginContainer/Panel/VBoxContainer/Results5/Time5
@onready var race_time: Label = $MarginContainer/Panel/VBoxContainer/RaceResult/RaceTime


var labelTimes = []
var RaceTime: float = 0


func _ready() -> void:
	Globals.race_ended.connect(RaceEnding)
	labelTimes = [time_1, time_2, time_3, time_4, time_5]
	
	
func RaceEnding():
	animation.play("EndRace")
	
	for x in Globals.LapTimes:
		RaceTime += x
	for i in range(1,len(Globals.LapTimes)):
		labelTimes[i-1].text = "%.2f" % Globals.LapTimes[i] + "s"
	race_time.text = "%.2f" % RaceTime + "s"
	Globals.Stop_moving = true


func _on_button_pressed() -> void:
	Globals.race_started = false
	Transition.play_animation(get_parent().scene_file_path)


func _on_back_to_game_choice_pressed() -> void:
	Globals.race_started = false
	Transition.play_animation("res://UI/GameChoice.tscn")
