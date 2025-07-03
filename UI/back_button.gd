extends HBoxContainer


func _on_back_pressed() -> void:
	Transition.play_animation("res://UI/HostingScene.tscn")
