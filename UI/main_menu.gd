extends Control





func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	Transition.play_animation("res://UI/HostingScene.tscn")
	Globals.SinglePlayer = false


func _on_single_player_pressed() -> void:
	Transition.play_animation("res://UI/GameChoice.tscn")
	Globals.SinglePlayer = true
