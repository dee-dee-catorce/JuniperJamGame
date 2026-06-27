extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	self.visible = false
	pass # Replace with function body.


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/area.tscn")
	pass # Replace with function body.


func _on_credits_pressed() -> void:
	self.visible = true
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	pass # Replace with function body.
