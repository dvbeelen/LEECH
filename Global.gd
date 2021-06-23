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
var doorCode = ['5', '7', '2', '9']
var introPlayed = false
var door1opened = false
var door2opened = false
var door3opened = false
var tutorialEndReached = false
var hintsSeen = 0
var questionsAnswered = 0

var givenAnswers = {
	0: '',
	1: '',
	2: '',
	3: '',
	4: '',
	5: '',
	6: '',
	7: '',
}

var advertisements = {
	0: 'Order ' + givenAnswers[0] + ' with DeliverFood today! \n second order half price!',
	1: 'Get the complete ' + givenAnswers[1] + ' collection on blueRay! \n Buy now!',
	2: 'Get the best ' + givenAnswers[2] + ' matches on cable! \n sign up now for a first free month!',
	3: 'The greatest hits of ' + givenAnswers[3] + ', now collected! \n limited edition, only for true fans!',
	4: 'Only real fans will now all the answers to this ' + givenAnswers[4] + 'quiz! \n can you get all questions correct?',
	5: 'Always running out of ' + givenAnswers[5] + '?! \n Sign up with us to get it delivered weekly!',
	6: 'Are ' + givenAnswers[6] + 'already old news? \n this aricle will shock you!',
	7: 'Study shows people who like ' + givenAnswers[7] + 'might be smarter then most! \n Find out why soon!',
}

#Internal info
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

func openHint():
	scene.get_node("HintsChat").visible = true
	scene.get_node("HintsChat/CanvasLayer/ColorRect").visible = true

func closeChat():
	scene.get_node("LEECHat").visible = false
	scene.get_node("LEECHat/CanvasLayer/ColorRect").visible = false

func closeHint():
	scene.get_node("HintsChat").visible  = false
	scene.get_node("HintsChat/CanvasLayer/ColorRect").visible = false

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

func updateAdvertisements():
	advertisements[0] = 'Order ' + givenAnswers[0] + ' with DeliverFood today! \n second order half price!'
	advertisements[1] = 'Get the complete ' + givenAnswers[1] + ' collection on blueRay! \n Buy now!'
	advertisements[2] = 'Get the best ' + givenAnswers[2] + ' matches on cable! \n sign up now for a first free month!'
	advertisements[3] = 'The greatest hits of ' + givenAnswers[3] + ', now collected! \n limited edition, only for true fans!'
	advertisements[4] = 'Only real fans will now all the answers to this ' + givenAnswers[4] + 'quiz! \n can you get all questions correct?'
	advertisements[5] = 'Always running out of ' + givenAnswers[5] + '?! \n Sign up with us to get it delivered weekly!'
	advertisements[6] = 'Are ' + givenAnswers[6] + 'already old news? \n this aricle will shock you!'
	advertisements[7] = 'Study shows people who like ' + givenAnswers[7] + 'might be smarter then most! \n Find out why soon!'
