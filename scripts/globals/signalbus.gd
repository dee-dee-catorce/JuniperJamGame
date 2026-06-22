extends Node


signal timerUpd(int)
signal button()
signal start()

func updateTimer(timer: int):
	print(timer)
	timerUpd.emit(timer)
	pass

func buttonp():
	button.emit()
	pass

func startf():
	start.emit()
	pass
#nothing yet but signals go here