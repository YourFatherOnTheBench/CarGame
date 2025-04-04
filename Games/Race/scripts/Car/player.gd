extends CharacterBody2D
@onready var boostimer: Timer = $boostimer
@onready var tween: Tween 
@onready var camera: Camera2D = $Camera2D

var cameraShakeNoise: FastNoiseLite

const Engine_power: float = 150
var acceleration = Vector2.ZERO
var wheel_base: float = 40
var steering_angle: float = 15
var car_velocity = Vector2.ZERO
var steer_direction: float
var friction: float = -0.66
var drag: float = -0.001
var friction_force
var drag_force
var braking: int = -75
const max_speed_reversal: int = 250
const max_wheel: int = 75
const min_wheel: int = 40
const slip_spped: int = 275
const traction_fast: float = 0.1
const traction_slow: float = 0.7
var max_steering_angle = 15  # Normal steeringa
var min_steering_angle = 5   # Reduced steering at high speed

func _ready() -> void:
	cameraShakeNoise = FastNoiseLite.new()
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	if is_multiplayer_authority():
		$Camera2D.make_current()
	
func _physics_process(delta: float) -> void:
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		acceleration = Vector2.ZERO
		if !Globals.Stop_moving:
			$CPUParticles2D2.emitting = true
			get_input()
		
		calculate_steering(delta)
		apply_friction()
		velocity += acceleration * delta
		move_and_slide()
	
func apply_friction():
	if velocity.length() < 1:
		velocity = Vector2.ZERO
		drag_force = 0 
		friction_force = 0
	friction_force = velocity * friction
	drag_force = velocity * velocity.length() * drag
	acceleration += drag_force + friction_force
	
func get_input():
	var turn = 0
	if Input.is_action_pressed("right"):
		turn += 30
	if Input.is_action_pressed("left"):
		turn -= 30
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("drive"):
		acceleration = transform.x * Engine_power
		if wheel_base < max_wheel:
			wheel_base += 0.08
	else:
		if wheel_base > min_wheel:
			wheel_base -= 1
	if Input.is_action_pressed("drive_back"):
		acceleration = transform.x * braking
	
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base/2.0
	var front_wheel = position + transform.x * wheel_base/2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	# ----- DRIFTING
	var traction = traction_slow
	if velocity.length() > slip_spped:
		traction = traction_fast
	
	
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		#if Input.is_action_pressed("drifting"):
		velocity = velocity.move_toward(new_heading * velocity.length(), 1)
		#else:
			#velocity = velocity.lerp(new_heading * velocity.length(), 1)
	if d < -0.85:
		velocity = -new_heading * min(velocity.length() , max_speed_reversal)
	rotation = new_heading.angle()


func boost():
	var camera_tween = get_tree().create_tween()
	camera_tween.tween_method(CameraShaking, 3.0, 1.0, 1)
	acceleration = acceleration.lerp(transform.x * 3, 0.8)
	drag = -0.0002
	friction = -0.3
	boostimer.start()

func _on_boostimer_timeout() -> void: 
	tween = create_tween()
	tween.tween_property(self, "drag", -0.001, 0.2)
	tween.tween_property(self, "friction", -0.7, 0.2)
	
func slow_down() -> void:
	drag = -0.0075
	
func on_track() -> void:
	drag = -0.001
	
func CameraShaking(intensity: float):
	var cameraOffset = cameraShakeNoise.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera.offset.x = cameraOffset
	camera.offset.y = cameraOffset
	
