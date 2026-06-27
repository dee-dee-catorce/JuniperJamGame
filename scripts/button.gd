extends Button

@export var store: Control
@export var gamble: Control
@export var dialogue: Control
@export var currencylabel: Control
@export var addaasdasxczxc: Control
@export var sound: AudioStreamPlayer2D

@export var speedb: Button
@export var timeb: Button
@export var carb: Button
var currency: int
var speedcost: int
var timecost: int


var failtimes: int = 0


var purchase = [
	{"text": "[wave]I may or may not have jacked up the price on that specifically for you... [/wave] Hm? I didn't say anything.", "expression": "haha", "speed": 0.90},
	{"text": "Have fun with that...", "expression": "haha", "speed": 1.10},
	{"text": "[wave][color=red]No refunds.[/color][/wave] Don't come crying to me if you dont like it.", "expression": "angry", "speed": 0.90},
]


var chud = [
	{"text": "person who made this game is a fat slobby loser so that button doesnt do anything", "expression": "haha", "speed": 1.10},

]
var perchasedeny = [
	{"text": "[shake][color=red]YOU ARE BROKE!!!!! GET SOME FUDGIN MONEY!!!!!!!!", "expression": "angry", "speed": 0.90},
	{"text": "I don't do handouts. Get your[color=green] money [/color] up son.", "expression": "angry", "speed": 0.90},
	{"text": "I can't do that.", "expression": "haha", "speed": 0.90},
]

var crashout = [
	{"text": "[shake][color=red]Leave and DON'T come back until you have money.", "expression": "angry", "speed": 1.1},
	{"text": "[shake][color=red]Get out. I'll put up with you again later", "expression": "angry", "speed": 1.1},
{"text": "[shake][color=red]I'm done with you. You're welcome back when you have MONEY.", "expression": "angry", "speed": 1.1},
]
func _ready() -> void:
	update_shop_variables()

func update_shop_variables() -> void:
	currency = Saveloadsys.data.get("currency", 0)
	speedcost = 200 * (1 + Saveloadsys.data.get("currspeed", 0))
	timecost = 200 * (1 + Saveloadsys.data.get("currtimeadd", 0))
	currencylabel.text = str(currency)
	speedb.text = str(speedcost)
	timeb.text = str(timecost)
	$Boop.play()

func _on_pressed() -> void:
	if store: store.visible = true
	if gamble: gamble.visible = false

func _on_ask_pressed() -> void:
	if store: store.visible = false
	if gamble: gamble.visible = false

func _on_gamble_pressed() -> void:
	if store: store.visible = false
	if gamble: gamble.visible = true

func _on_button_pressed() -> void:
	update_shop_variables()

	if failtimes >= 20:
		crashoutf()
	if failtimes > 21:
		return

	if currency >= speedcost:
		failtimes = 0
		dialogue.startDialogue([purchase.pick_random()])
		Saveloadsys.data["currency"] -= speedcost

		Saveloadsys.data["currspeed"] += 1
		update_shop_variables()
	else:
		failtimes += 1
		dialogue.startDialogue([perchasedeny.pick_random()])
		print("broke alert")

func _on_button_2_pressed() -> void:
	update_shop_variables()
	if failtimes >= 20:
		crashoutf()
	if failtimes > 21:
		return

	if currency >= timecost:
		failtimes = 0
		dialogue.startDialogue([purchase.pick_random()])
		Saveloadsys.data["currency"] -= timecost
		Globals.timeup += 1
		Saveloadsys.data["currtimeadd"] += 1
		update_shop_variables()
	else:
		failtimes += 1
		dialogue.startDialogue([perchasedeny.pick_random()])
		#print("Not enough currency for time upgrade!")


func crashoutf():
	dialogue.startDialogue([crashout.pick_random()])
	self.visible = false
	currencylabel.text = "broke"
	self.get_parent().get_parent().get_parent().bye = true
	clossall()
	await get_tree().create_timer(3).timeout

func clossall():
	store.visible = false
	
	gamble.visible = false


func _on_button_3_pressed() -> void:
	dialogue.startDialogue([chud.pick_random()])
	pass # Replace with function body.
