extends Node3D

var zoom_step_size : float
@onready var zoom_target : float = $Camera3D.position.z

#rotation stuff
var mouse_1
var mouse_2
var mouse_delta
var initial_rotation
var rotation_strength = .05

#zoom stuff
var zoom_min = 2 # change this so it varies with the size of the target.
var zoom_b_distance = 20 #width of intended zoom field
var zoom_b_strength = 4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin.player_camera = self
	var t = (position.z-zoom_min) * 1.0/zoom_b_distance
	zoom_step_size = 0.01 * (1-t) + zoom_b_strength * t

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoom out"):
		var t = ($Camera3D.position.z-zoom_min) * 1.0/zoom_b_distance
		zoom_step_size = 0.5 * (1-t) + zoom_b_strength * t
		zoom_target += zoom_step_size
	if Input.is_action_just_pressed("zoom in"):
		var t = ($Camera3D.position.z-zoom_min) * 1.0/zoom_b_distance
		zoom_step_size = 0.1 * (1-t) + zoom_b_strength * t
		zoom_target = clamp(zoom_target - zoom_step_size, zoom_min, INF)
	
	$Camera3D.position.z = lerp($Camera3D.position.z, 1.0*zoom_target, ease(2*delta, .2))
	
	if Input.is_action_just_pressed("rotate around target"):
		mouse_1 = get_viewport().get_mouse_position()
		initial_rotation = rotation
	if Input.is_action_pressed("rotate around target"):
		mouse_2 = get_viewport().get_mouse_position()
		mouse_delta = mouse_2 - mouse_1
		var scale_to_screen_size = (1920.0/get_viewport().size.x + 1080.0/get_viewport().size.y)/2.0
		#rotation.x = initial_rotation.x + -1.0 * scale_to_screen_size * rotation_strength * mouse_delta.y/(2*PI)
		var overtilt_blocker = PI/32
		rotation.x = clampf(initial_rotation.x + -1.0 * scale_to_screen_size * rotation_strength * mouse_delta.y/(2*PI), -PI + overtilt_blocker, 0 - overtilt_blocker)
		rotation.y = initial_rotation.y + -1.0 * scale_to_screen_size * rotation_strength * mouse_delta.x/(2*PI)
	
		
