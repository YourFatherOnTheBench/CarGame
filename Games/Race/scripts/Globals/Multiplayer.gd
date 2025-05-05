extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"
var Players = {}

func _ready():
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.server_disconnected.connect(server_disconnected)
	Globals.sync_data.connect(sync)


func sync(pid, lap_time):
	transfer_data_to_server.rpc_id(1, pid, lap_time)
	sync_data_with_peers.rpc(pid, Players[pid])

#func test(pid, lap_time)


@rpc("authority", "call_local")
func transfer_data_to_server(pid,lap_time):

	Players[pid]["Laps"].append(snapped(lap_time, 0.01))
	Players[pid]["time"] = 0
	Players[pid]["LapsMade"] += 1

@rpc("any_peer", "call_local")
func sync_data_with_peers(pid, dict):
	Players[pid] = dict




func join():
	if multiplayer.is_server():
		print("You have joined the lobby")
		var client_peer = ENetMultiplayerPeer.new()
		client_peer.create_client(SERVER_IP, SERVER_PORT)
		client_peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.set_multiplayer_peer(client_peer)

	
	
func host():
	if multiplayer.is_server() != null:
		print("you are host")
		var peer = ENetMultiplayerPeer.new()
		var error = peer.create_server(SERVER_PORT,2 )
		if error != OK:
			print("cannot host: %s " % error)
			return
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.set_multiplayer_peer(peer)
		multiplayer.peer_connected.connect(_add_player_to_game)
		multiplayer.peer_disconnected.connect(_kick_player)
		SendPlayerInformations("HOST", multiplayer.get_unique_id())

func connected_to_server():
	print("connected to server")
	SendPlayerInformations.rpc_id(1, "Sigma", multiplayer.get_unique_id())
func server_disconnected():
	pass

func _add_player_to_game(pid: int):
	print("Player %s has connected to the game" % pid)
	print("Current players:")
	for p in Players:
		print(" -> %s (%s)" % [Players[p].name, p])
	
	
func _kick_player(pid: int):
	print("Player %s has disconnected from the game" % pid)
	if Players.has(pid):
		Players.erase(pid)
		print("Removed player %s from server dictionary" % pid)
		RemovePlayerFromClients.rpc(pid)  # Broadcast to all clients

	var players = get_tree().get_nodes_in_group("Players")
	for i in players:
		if i.name == str(pid):
			i.queue_free()
			
@rpc("call_remote")
func RemovePlayerFromClients(id):
	if Players.has(id):
		Players.erase(id)
		print("Player %s removed on client" % id)


	
@rpc("any_peer")
func SendPlayerInformations(name, id):
	if !Players.has(id):
		Players[id] = {
			"name": name,
			"id": id,
			"Laps": [],
			"time": 0.00,
			"LapsMade": 5,
			"CheckpointsMade": 0
		}
	if multiplayer.is_server():
		for i in Players:
			SendPlayerInformations.rpc(Players[i].name, i)
			
func check_laps(pid):
	if Players[pid]["LapsMade"] > 5:
		Globals.can_end.emit()
	
