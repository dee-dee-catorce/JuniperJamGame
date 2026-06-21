extends RigidBody2D
@onready
var expie = $Expie
var dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		return
	if body is RigidBody2D:
		if dead == true:
			return
		dead = true
		expie.frame = 1
		$Crash.play()
		pass
	pass # Replace with function body.
