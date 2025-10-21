extends CharacterBody3D
class_name combat

const stat_ranges = {
	"attack": Vector2(0, 1000),
	"attacks_per_second": Vector2(0, 5),
	"max_health": Vector2(1, 10000),
	"resistance": Vector2(0, .8),
	"speed": Vector2(0, 20),
	"range": Vector2(0, 20)
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
var speed = 20
var range


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
