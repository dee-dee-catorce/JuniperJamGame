extends Control
@export var rich: RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(.2).timeout
	$postprocess/del.queue_free()
	reveaL()
	flash()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func reveaL():
	while get_tree():
		await get_tree().create_timer(.05).timeout
		rich.visible_characters += 1
	pass
func flash():
	while get_tree():
		await get_tree().create_timer(.5).timeout
		rich.visible = true
		await get_tree().create_timer(1.5).timeout
		rich.visible = false
		
	pass