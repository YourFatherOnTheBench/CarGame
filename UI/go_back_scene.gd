extends CanvasLayer

func _ready() -> void:
	if !Globals.SinglePlayer:
		queue_free()

func _on_button_pressed() -> void:
	#if Globals.SinglePlayer:
	goBacktoGameChoice()

		#rpc_id(multiplayer.get_unique_id(), "goBackToHostingScene")

#@rpc("call_local")
#func goBackToHostingScene():
	#if multiplayer.multiplayer_peer:
		#multiplayer.multiplayer_peer.close()
		#multiplayer.set_multiplayer_peer(null)
	#Transition.play_animation("res://UI/Main_menu.tscn")
	
func goBacktoGameChoice():
	Transition.play_animation("res://UI/GameChoice.tscn")
