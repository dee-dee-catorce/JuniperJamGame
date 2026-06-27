extends Node2D

var dialogue: Array = [
	{"text": "Woah!", "expression": "default", "speed": 1.0},
]

var angry: Array = [
	{"text": "someones not getting the memo. [color=red] ur broke and i want nothing to do with you", "expression": "angry", "speed": 1.0},
]

var test2: Array = [
	{"text": "I'm actually selling something now!", "expression": "default", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	{"text": "[tornado radius=2.5 freq=1.5 connected=1] Buy it.", "expression": "cute", "speed": 0.90},
	
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shop_body_entered(body: Node2D) -> void:
	if body.name == "playerhuman":
		$store.visible = true

		if $store/store.bye == false:
			$store/store.startDialogue(test2)
		else:
			$store/store.startDialogue(angry)
	pass # Replace with function body.


func _on_shop_body_exited(body: Node2D) -> void:
	if body.name == "playerhuman":
		$store.visible = false

	pass # Replace with function body.
