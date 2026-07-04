extends Camera2D

@export var move_speed = 30
@export var zoom_speed = 3.0
@export var min_zoom = 5.0
@export var max_zoom = 0.5
@export var margin = Vector2(400,200)

@onready var screen_size = get_viewport_rect().size

var players = []

func add_player(p):
	if p not in players:
		players.append(p)
		
func remove_player(p):
	if p in players:
		players.erase(p)
func _physics_process(delta: float) -> void:
	if !players:
		return
	
	var p = Vector2.ZERO
	for player in players:
		p += player.position
	p /= players.size()
	position = lerp(position, p, move_speed * delta)
	
	var r = Rect2(position, Vector2.ONE)
	for player in players:
		r = r.expand(player.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = 1 / clamp(r.size.x / screen_size.x, max_zoom, min_zoom)
	else:
		z = 1 / clamp(r.size.y / screen_size.y, max_zoom, min_zoom)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed * delta)
	
	
	
	
#func CameraShaking(intensity: float):
	#var cameraOffset = cameraShakeNoise.get_noise_1d(Time.get_ticks_msec()) * intensity
	#camera.offset.x = cameraOffset
	#camera.offset.y = cameraOffset
	#
	#
	
	
	
	
	
	
	
