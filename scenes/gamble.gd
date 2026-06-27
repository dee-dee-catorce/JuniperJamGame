extends ColorRect

@export var asdasd: RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ask_pressed() -> void:
	var a = Saveloadsys.data["currency"] * randf_range(0.0, 3.0)

	asdasd.text = str(
		snapped(a, 1)
		
		
		)
	Saveloadsys.data["currency"] = snapped(a, 1)
	pass # Replace with function body.
