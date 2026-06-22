extends Node2D
#planning because this is without a doubt gonna be the hardest part of the game to code
# select a random track from the folder with the tracks
#instance it into here
#get the last generated cart and grab the endnode position of that one
#move the track to there 
# all the track scenes we find in the folder get stored here
var sceneLoads = []

# these tracks are guaranteed to exist (like the spawn track)
var tracks = {
	0: "spawn.tscn",
	1: "spawn.tscn",
	2: "spawn.tscn",
	3: "spawn.tscn",
	4: "spawn.tscn",
}


var lastTrack

var tracknum = 0
@export
var tracka: Node2D
var lastSceneResource


func _ready() -> void:
	# scan the tracks folder and fill sceneLoads
	dirContents("res://scenes/tracks")
	# generate the first track
	gen()


#i had a game with very similiar generation to this one (nuke train) so alot of the code here is reused

func dirContents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
			# only grab actual scene files not folders
			if not dir.current_is_dir():
				if fileName.get_extension() == "tscn":
					var fullPath = path.path_join(fileName)
					sceneLoads.append(load(fullPath))
			fileName = dir.get_next()


func gen():
	var guaranteed = tracks.values()
	var randomPool = sceneLoads.filter(func(res):
		var fileName = res.resource_path.get_file()
		return fileName not in guaranteed
	)

	if lastSceneResource != null:
		randomPool = randomPool.filter(func(res):
			return res != lastSceneResource
		)

	var sceneResource

	if lastTrack == null:
		sceneResource = load("res://scenes/tracks/" + tracks[0])
	else:
		sceneResource = randomPool.pick_random()

	# just in case something went wrong
	if !sceneResource:
		if Globals.devMode:
			print("its fucked up")
		return

	
	lastSceneResource = sceneResource

	
	var newTrack = sceneResource.instantiate()
	
	add_child(newTrack)
	tracka = newTrack
	
	if lastTrack:
		var endPos = lastTrack.end.global_position
		var startOffset = newTrack.start.position
		#newTrack.rotation += lastTrack.end.rotation
		newTrack.global_position = endPos - startOffset

	
	newTrack.trigger.body_entered.connect(_on_trigger_entered)

	
	if Globals.devMode:
		print(tracka)
	lastTrack = newTrack
	tracknum += 1
	print(tracknum)
	if tracknum == 2:
		Signalbus.startf()

func _on_trigger_entered(body):
	# only care about the player
	if body.name == "player":
		gen()
