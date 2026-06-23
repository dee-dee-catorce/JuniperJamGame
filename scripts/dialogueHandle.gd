extends Node2D

@export
var textspeed: float = 0.04
@export
var rtl: RichTextLabel

@export
var spr: Sprite2D


var isTyping: bool = false


var expressions = {
	"default": 0,
	"angry": 1
	}


var pause: Array = [
	",",
	".",
	"!",
	"?"
	#etc

]
func _ready() -> void:
	box("hello", "angry", 1)
	
	box("IM GONNA KILL SOMEONE OH MY GOSH", "default", 1)
	pass


func box(stri: String, expression: String, spd: float):
	typeOut(rtl, stri, spd)


	print(expressions.get(expression))
	if !expressions.get(expression):
		spr.frame = 0
	spr.frame = expressions.get(expression)


	pass

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
		i += 1
