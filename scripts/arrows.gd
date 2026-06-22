extends Node2D

@export var track: Node2D
@export var yesprite: Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.look_at(track.tracka.end.global_position)
	$Node2D.look_at(get_global_mouse_position())
	#self.global_rotation = lerp(self.global_rotation, get_angle_to(track.tracka.end.global_position), .4)
	#print(track.tracka.end.position)
	pass
