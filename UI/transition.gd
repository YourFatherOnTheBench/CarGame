extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer



func play_animation(Scene):
	animation.play("Transition")
	await animation.animation_finished
	get_tree().change_scene_to_file(Scene)
	animation.play_backwards("Transition")
