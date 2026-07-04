extends HBoxContainer
@onready var placeLabel: Label = $place
@onready var nameLabel: Label = $name
@onready var time: Label = $time
var id: String = "1"
var place: String = "-1"
var sum: float = 0


func _ready() -> void:
	placeLabel.text = place
	nameLabel.text = Globals.Players[id]["name"]
	for number in Globals.Players[id]["Laps"]:
		sum += number
	time.text = " %.2f" % sum + "s"
