extends Node


func _on_button_pressed() -> void:
	self.visible = false


func _on_check_box_toggled(toggled_on: bool) -> void:
	Saveloadsys.settings["spin"] = toggled_on
	print(Saveloadsys.settings["spin"])
	var check: Button = $CheckBox
	if toggled_on:
		check.text = "camera spinning: on"
	else:
		check.text = "camera spinning: off"


func _on_settings_pressed() -> void:
	self.visible = true
	$score.text = str(Saveloadsys.data["topspeedalltime"])
