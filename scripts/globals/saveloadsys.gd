extends Node


"""
###


yeah because im not recoding this especially with how incomplete my game is

TOTALLY not just reused from my desktop pet thing


This is the thing that handles saving and loading. 

Heres the steps that it does through:

    Loading:
        1: Check if there is a save file. If there is, load it into data        2: Check for a translation file in deedee/expet/lang. If there is, load it into the translation system.
        3: If there isnt. load yapENG into text.
        
    Saving:
        1: Check if there is a save file. If there isnt, make one.
        2: Save data inside the data variable to the save file.

    Creating a new file:
        1: Read SaveTemplate.json.
        2: Apply save template to data. 
        3: Randomize some variables 
        4: Create a new JSON file based on whats in data


this shit sound like ai wrote it im sorry it sounds like that 


"""

var data = {}

var settings = {}

var template = "res://scripts/json/SaveTemplate.json"


var savePath = "user://SAVE.json"
var conPath = "user://CONFIG.json"

func _ready():
	# Load save file
	if FileAccess.file_exists(savePath):
		data = loadjson(savePath)
		if Globals.devMode:
			newsave()
			pass
	else:
		newsave()
	

	# Load settings/config file
	if FileAccess.file_exists(conPath):
		settings = loadjson(conPath)
		if Globals.devMode:
			newConfig()
			
	else:
		newConfig()

	InitAutosave()

func newsave():
	# Read the save template
	if template == null:
		print("template not found")
		return
	
	#set data json to template
	data = loadjson(template).duplicate(true)

	randomize()

	savetodisk(savePath, data)


func newConfig():
	var configFile = "res://scripts/json/ConfigTemplate.json"

	settings = loadjson(configFile).duplicate(true)
	savetodisk(conPath, settings)
# my favorite helpers!
#theyre gone nvm
func loadjson(filepath: String):
	if FileAccess.file_exists(filepath):
		var datafile = FileAccess.open(filepath, FileAccess.READ)
		var parsedresult = JSON.parse_string(datafile.get_as_text())
		if parsedresult is Dictionary:
			return parsedresult
		else:
			if Globals.devMode:
				print("Error parsing JSON file: " + filepath)
			return {}
	else:
		if Globals.devMode:
			print("File not found: " + filepath)
		return {}

func savetodisk(path, dt):
		var file = FileAccess.open(path, FileAccess.WRITE)
		if file:
			var json_string = JSON.stringify(dt, "\t")
			file.store_line(json_string)
			file.close()


func InitAutosave():
	while true:
		await get_tree().create_timer(10.0).timeout
		if Globals.devMode:
			print("saved")
		savetodisk(savePath, data)
		savetodisk(conPath, settings)
