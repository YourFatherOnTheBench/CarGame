extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _process(_delta: float) -> void:
	await animation_player.animation_finished
	Globals.Stop_moving = false

	
	
