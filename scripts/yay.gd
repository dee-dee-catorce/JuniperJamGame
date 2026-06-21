extends "res://scripts/sprSheetPlay.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var num = randi_range(1, 100)
	if num == 50:
		pass
	else:
		self.get_parent().queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
