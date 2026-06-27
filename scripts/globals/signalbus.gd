extends Node


signal timerUpd(int)
signal button(int)
signal start()

func updateTimer(timer: int):
	print(timer)
	timerUpd.emit(timer)
	pass

func buttonp(inta: int):
	button.emit(inta)
	pass

func startf():
	start.emit()
	pass
#nothing yet but signals go here