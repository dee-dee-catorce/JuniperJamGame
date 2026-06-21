extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	pass # Replace with function body.


func play():
	while get_tree():
		if frame == hframes - 1:
			frame = 0
		frame += 1
		await get_tree().create_timer(.1).timeout