extends Control
@onready
var speedometer = $speed

@export
var body: RigidBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speedometer.text = str(
			snappedf(
				abs(body.linear_velocity.length()),
				1
			) / 10
		) + " / U"
	pass
