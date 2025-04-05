extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"
var Players = {}

func _ready():
	multiplayer.connected_to_server.connect(connected_to_server)



func join():
	print("You have joined the lobby")
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	client_peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(client_peer)
	
	
func host():
	print("you are host")
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(SERVER_PORT,2 )
	if error != OK:
		print("cannot host: " + error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_kick_player)
	SendPlayerInformations("HOST", multiplayer.get_unique_id())

func connected_to_server():
	print("connected to server")
	SendPlayerInformations.rpc_id(1, "Sigma", multiplayer.get_unique_id())


func _add_player_to_game(pid: int):
	print("Player %s has connected to the game" % pid)
	
	
func _kick_player(pid: int):
	print("Player %s has disconnected from the game" % pid)
	
@rpc("any_peer")
func SendPlayerInformations(name, id):
	if !Players.has(id):
		Players[id] = {
			"name": name,
			"id": id,
			"Laps": []
		}
	if multiplayer.is_server():
		for i in Players:
			SendPlayerInformations.rpc(Players[i].name, i)
			
	
	
