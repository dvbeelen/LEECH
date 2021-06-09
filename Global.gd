extends Node

var current_frame = ""

var red_frame: bool = false
var green_frame: bool = false
var blue_frame: bool = false


#Player information
var playerName = "Player 1"
var playerColor = ''
var roomName = "1"
var maxCharactersForChat = 70

var root
var scene

func _ready():
	root = get_tree().get_root()
	scene = root.get_child( root.get_child_count() -1 )

func gotoScene(path):
	call_deferred("_deferred_gotoScene", path) 

func _deferred_gotoScene(path):
	scene.free()
	var res = ResourceLoader.load(path)
	scene = res.instance()
	scene.connect("tree_entered", get_tree(), "set_current_scene", [scene], CONNECT_ONESHOT)
	root.add_child(scene)
