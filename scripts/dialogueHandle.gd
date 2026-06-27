extends Node

@export var textspeed: float = 0.04
@export var rtl: RichTextLabel
@export var spr: Sprite2D
@export var turn: int
@export var storenode: Node2D

var bye = false
var isTyping: bool = false
var dialogueActive: bool = false
var currentIndex: int = 0
var activeSequence: Array = []

var expressions = {
	"default": 0,
	"angry": 1,
	"shocked": 2,
	"haha": 3,
	"cute": 4
}

var pause: Array = [",", ".", "!", "?"]

var buy = [

	{"text": "No refunds!", "expression": "angry", "speed": 1},
]


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if !dialogueActive:
			return
		if isTyping:
			skipTyping()
		else:
			advanceDialogue()


func startDialogue(arr: Array) -> void:
	$Wagh2.pitch_scale = randf_range(.9, 1.11)
	$Wagh2.play()
	activeSequence = arr
	currentIndex = 0
	dialogueActive = true
	showCurrent()


func advanceDialogue() -> void:
	currentIndex += 1
	if currentIndex < activeSequence.size():
		showCurrent()
	else:
		endDialogue()


func showCurrent() -> void:
	var entry = activeSequence[currentIndex]
	box(entry["text"], entry["expression"], entry["speed"])


func endDialogue() -> void:
	dialogueActive = false
	isTyping = false


func skipTyping() -> void:
	isTyping = false
	await get_tree().process_frame
	rtl.visible_characters = -1


func box(stri: String, expression: String, spd: float):
	typeOut(rtl, stri, spd)
	spr.frame = expressions.get(expression, 0)


func typeOut(richlabel: RichTextLabel, string: String, speed_multiplier: float = 1.0):
	if isTyping:
		isTyping = false
		await get_tree().process_frame

	isTyping = true
	richlabel.text = string
	richlabel.visible_characters = 0

	var i = 0

	while i < string.length() and isTyping:
		if string[i] == "[":
			while i < string.length() and string[i] != "]":
				i += 1
			i += 1
			continue

		richlabel.visible_characters += 1
		var current_char = string[i]

		var wait = textspeed * speed_multiplier
		if current_char in pause:
			wait *= 8
		await get_tree().create_timer(wait).timeout
		$Wagh.play()
		$Wagh.pitch_scale = randf_range(.9, 1.11)
		i += 1

	if isTyping:
		isTyping = false
		richlabel.visible_characters = -1

func _on_button_pressed() -> void:
	startDialogue(buy)
	pass # Replace with function body.
