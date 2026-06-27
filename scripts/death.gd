extends Control
@export var rich: RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eastereggs()
	rich.text = "
	PLAYER DIED

	EARNED " + str(Globals.earnings) + " MONEY
	
	WELL ACTUALLY YOU GOT 200 BUT THATS CUS
	I HAVENT IMPLEMENTED ACTUAL MATH FOR
	EARNING MONEY

	R TO RESTART
	"

	Saveloadsys.data["currency"] += 100
	await get_tree().create_timer(.05).timeout
	$postprocess/ColorRect2.queue_free()
	await get_tree().create_timer(.1).timeout
	$postprocess/del.queue_free()
	reveaL()
	flash()


	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("r"):
		get_tree().change_scene_to_file("res://scenes/area.tscn")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func reveaL():
	while get_tree():
		await get_tree().create_timer(.02).timeout
		rich.visible_characters += 1
	pass
func flash():
	while get_tree():
		await get_tree().create_timer(.5).timeout
		rich.visible = true
		await get_tree().create_timer(1.5).timeout
		rich.visible = false
		
	pass

func eastereggs():
	var num = randi_range(1, 100)
	if num >= 90:
		pass
	else:
		$postprocess/Yay.queue_free()
		pass
	pass # Replace with function body.