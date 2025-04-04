extends CanvasLayer

@onready var timeLabel: Label = $Control/marginConainer/Panel/ColorRect/Label


var time: float = 0.00





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.race_started and !Globals.Stop_moving:
		time += delta
		timeLabel.text = " Time:   %.2f" % time + "s"
