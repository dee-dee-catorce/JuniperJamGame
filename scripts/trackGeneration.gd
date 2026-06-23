extends Node2D

var sceneLoads = []

var trackPaths = [
	"res://scenes/tracks/spawn.tscn",
	"res://scenes/tracks/spawn2.tscn",
	"res://scenes/tracks/spawn3.tscn",
	"res://scenes/tracks/a.tscn",
]

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
	if OS.get_name() == "Web":
		for path in trackPaths:
			var res = load(path)
			if res:
				sceneLoads.append(res)
	else:
		dirContents("res://scenes/tracks")
	gen()


func dirContents(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var fileName = dir.get_next()
		while fileName != "":
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
		newTrack.global_position = endPos - startOffset

	newTrack.trigger.body_entered.connect(_on_trigger_entered)

	if Globals.devMode:
		print(tracka)
	lastTrack = newTrack
	tracknum += 1
	print(tracknum)
	if tracknum == 5:
		Signalbus.startf()

func _on_trigger_entered(body):
	if body.name == "player":
		gen()