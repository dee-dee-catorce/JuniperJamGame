extends RapierRigidBody2D

@export var speed: float

@export var pin: RapierPinJoint2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pin.motor_target_velocity = speed
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/death.tscn")
	pass # Replace with function body.
