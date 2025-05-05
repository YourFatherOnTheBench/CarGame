extends Control


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_single_player_pressed() -> void:
	Transition.play_animation("res://UI/GameChoice.tscn")
	Globals.SinglePlayer = true

func _on_host_pressed() -> void:
	Transition.play_animation("res://UI/HostingScene.tscn")
	Globals.SinglePlayer = false
	Multiplayer.host()

func _on_join_pressed() -> void:
	Transition.play_animation("res://UI/HostingScene.tscn")
	Globals.SinglePlayer = false
	Multiplayer.join()
