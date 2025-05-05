extends HBoxContainer
@onready var placeLabel: Label = $place
@onready var nameLabel: Label = $name
@onready var time: Label = $time
var id: int = 1
var place: String = "-1"
var sum: float = 0


func _ready() -> void:
	placeLabel.text = place
	nameLabel.text = Multiplayer.Players[id]["name"]
	for number in Multiplayer.Players[id]["Laps"]:
		sum += number
	time.text = " %.2f" % sum + "s"
