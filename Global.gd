extends Node

#Player information
var playerName = "Player 1"
var playerColor = ''
var playerFact1 = ''
var playerFact2 = ''
var playerFact3 = ''

#Game information
var maxCharactersForChat = 70
var doorUnlocked = false
var doorCode = ['0', '9', '7', '4']
var introPlayed = false

var root
var scene
var mouseRotationEnabled = true

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

func addSceneToCurrentScene(new_scene):
	scene.add_child(new_scene.instance())

func openChat():
	playerStateSwitch()
	if !introPlayed:
		scene.get_node("GameStart").visible = true
		scene.get_node("GameStart/CanvasLayer/ColorRect").visible = true
	else:
		scene.get_node("LEECHat").visible = true
		scene.get_node("LEECHat/CanvasLayer/ColorRect").visible = true

func closeChat():
	scene.get_node("LEECHat").visible = false
	scene.get_node("LEECHat/CanvasLayer/ColorRect").visible = false

func playerStateSwitch():
	scene.get_node("Player").playerStateSwitch()

func showInteractionPrompt():
	scene.get_node("Player").showInteractionPrompt()

func hideInteractionPrompt():
	scene.get_node("Player").hideInteractionPrompt()

func addInteractableToCamera(path):
	var interactableScene = load(path)
	var interactable = interactableScene.instance()
	scene.get_node("Player/camera/CanvasLayer").add_child(interactable)

func removeInteractableFromCamera(nodeName):
	var removeNode = scene.get_node("Player/camera/CanvasLayer").get_node(nodeName)
	removeNode.queue_free()
	if !mouseRotationEnabled:
		mouseRotationEnabled = true
