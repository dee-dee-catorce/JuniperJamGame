extends Node


signal timerUpd(int)


func updateTimer(timer: int):
	timerUpd.emit(timer)
	pass
#nothing yet but signals go here