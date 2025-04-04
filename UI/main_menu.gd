extends Control





func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	Transition.play_animation("res://UI/GameChoice.tscn")
