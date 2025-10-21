extends CharacterBody3D
class_name bot

var camera_angle = 0
var manual_override = false

const stat_ranges = {
	"attack": Vector2(0, 1000),
	"attacks_per_second": Vector2(0, 5),
	"max_health": Vector2(1, 10000),
	"resistance": Vector2(0, .8),
	"speed": Vector2(0, 10),
	"range": Vector2(0, 10)
}

# base stats (should range 1-10, effectively normalized)
var atk
var aps
var m_hp
var res
var spd
var rng

# effective stats ((base * scaling) * multipliers) 
var attack
var attacks_per_second
var max_health
var resistance
var speed = 10
var range

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if manual_override:
		var input : Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
		velocity = speed * Vector3(input.x, 0, input.y).rotated(Vector3(0, 1, 0), origin.player_camera.global_rotation.y)
		move_and_slide()

func pick_me():
	manual_override = true

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		pick_me()
