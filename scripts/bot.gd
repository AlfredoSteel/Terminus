extends combat
class_name bot

var player_selected = false

var team = "player"
var target = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_selected and origin.manual_override:
		var cam = origin.player_camera
		var input : Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
		var absolute = Vector3(input.x, 0, input.y).rotated(Vector3(0, 1, 0), cam.global_rotation.y)
		var camera_position = cam.get_camera_global_position()
		var projected_camera_position = Vector3(camera_position.x, self.position.y, camera_position.z)
		var dir_to_camera = projected_camera_position - global_transform.origin
		var dir_to_camera_len = dir_to_camera.length()
		var dir_to_camera_norm = dir_to_camera / dir_to_camera_len if dir_to_camera_len > 0.0001 else Vector3.ZERO
		var fb_world = dir_to_camera_norm * input.y
		var lr_world = Vector3(input.x, 0, 0).rotated(Vector3(0, 1, 0), cam.global_rotation.y)
		var projected_vector = (fb_world + lr_world)
		var camera_facing = Vector3.FORWARD.rotated(Vector3.UP, cam.global_rotation.y)
		var alignment = camera_facing.dot(-1 * dir_to_camera_norm)
		alignment = (alignment + 1) / 2
		var t = (origin.treat_angles(cam.global_rotation.x) - cam.pitch_min) / (cam.pitch_max - cam.pitch_min)
		var final_vector = absolute.lerp(projected_vector, t)
		velocity = final_vector * speed
		move_and_slide()

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		pick_me()

func pick_me():
	origin.gui_target(self)
	if team == "player":
		player_selected = true
