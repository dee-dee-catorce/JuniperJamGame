extends Node2D
@export
var textspeed: float = 0.04
var isTyping: bool = false

var pause: Array = [
	",",
	".",
	"!",
	"?"
	#etc

]
# I KNOW THESE SHOULDNT BE HARDCODEED BUT ITS A GAME JAM WHO CARES
var st = "

[tornado radius=2.5 freq=1.5 connected=1][color=red]WARNING[/color]

THIS GAME CONTAINS:

FLASHING LIGHTS,
LOUD AND DISTRESSING NOISES,
WELL IT WAS GONNA HAVE ALOT OF SPINNING BUT I RAN OUT OF TIME

AND ALSO MIGHT MAKE FUN OF YOU IF YOU SUCK AT THE GAME.
"


var st2 = "

[tornado radius=1.5 freq=1.5 connected=1]heads up

flashing,
loud noises,
mean words.

the creator of this game thinks it sucks

you get the deal by now, eh?

"

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	
	print(Saveloadsys.settings.playflag)
	if Saveloadsys.settings.playflag == false:
		typeOut($CanvasLayer/VBoxContainer/start, st, 1.0)
	else:
		typeOut($CanvasLayer/VBoxContainer/start, st2, .9)

	pass # Replace with function body.

func _process(delta: float) -> void:
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
		$Click.play()
		await get_tree().create_timer(wait).timeout
		i += 1
		
		
	isTyping = false
	if Saveloadsys.settings.playflag == true:
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/gsdfsdgf.tscn")
	else:
		await get_tree().create_timer(1).timeout
		$CanvasLayer/VBoxContainer/button.visible = true
	Saveloadsys.settings.playflag = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("r"):
		get_tree().change_scene_to_file("res://scenes/gsdfsdgf.tscn")
	pass


func _on_button_pressed() -> void:
	$XaShortfxAir.play()
	$CanvasLayer/VBoxContainer/button.disabled = true
	
	await get_tree().create_timer(1).timeout
	typeOut($CanvasLayer/VBoxContainer/oo, "[tornado radius=2.5 freq=1.5 connected=1]... this was made for a game jam sorry if it sucks i have zero plan to update this k bye")

	pass # Replace with function body.
