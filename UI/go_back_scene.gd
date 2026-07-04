extends CanvasLayer


func _on_button_pressed() -> void:
	if Globals.SinglePlayer:
		goBacktoGameChoice()
	else:
		goBacktoGameChoice()

@rpc("call_local")
func goBackToHostingScene():
	if multiplayer.multiplayer_peer:
		multiplayer.multiplayer_peer.close()
		multiplayer.set_multiplayer_peer(null)
	Transition.play_animation("res://UI/Main_menu.tscn")
	
func goBacktoGameChoice():
	Transition.play_animation("res://UI/GameChoice.tscn")
