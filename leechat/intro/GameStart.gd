extends Control

onready var chatLog = $boxContainer/chatLog
onready var writeLine = $boxContainer/HBoxContainer/writeLine
onready var nameLabel = $boxContainer/HBoxContainer/Label

var playerNameSet = false
var playerColorSet = false

var availableColors = ["red", "blue", "green", "yellow", "purple", "pink", "brown", "white"]
var colorCodes = {
	"red": "#B20000",
	"blue": "#0BB5FF",
	"green": "#00b300",
	"yellow": "#FFFF00",
	"purple": "#800080",
	"pink": "#FF69B4",
	"brown": "#523A28",
	"white": "#ffffff",
}
func _ready():
	chatLog.text = "Welcome to LEECHat! To talk to your co-player, I will need your name please..."

func startChat():
	writeLine.grab_focus()

func _process(_delta):
	if self.visible:
		startChat()
		if Input.is_action_just_pressed("enter"):
			chatLogPrint(Global.playerName, writeLine.text)
			writeLine.clear()
		if Input.is_action_just_pressed("escape"):
			Global.playerStateSwitch()
			Global.closeChat()

func chatLogPrint(username, text):
#	Setting playername for the first time
	if !playerNameSet && Global.playerName == 'Player 1':
		print('setting player name')
		Global.playerName = text
		nameLabel = Global.playerName
		chatLog.text = "So your name is " + Global.playerName + "? Yes or No?"
		return
#	Confirming with player that given name is okay
	if !playerNameSet && Global.playerName != 'Player 1':
		print('confirming player name')
#		Name is okay, moving to colors
		if text == 'yes':
			playerNameSet = true
			chatLog.text = "Name set to: " + Global.playerName 
			yield(get_tree().create_timer(2.5), 'timeout')
			chatLog.text = "Next, can you type in your favorite color please..."
			return
#		Name is not okay, asking again
		else:
			Global.playerName = 'Player 1'
			chatLog.text = "Please type in your name"
			return
#	Asking the player for their favorite color, to set the text with
	if playerNameSet && !playerColorSet:
#		If given color is known, set the color and start the game
		if text in availableColors:
			print('setting player color')
			chatLog.text = "Favorite color set to " + text + " . Please wait..."
			Global.playerColor = colorCodes[text]
			print(Global.playerColor)
			playerColorSet = true
			yield(get_tree().create_timer(2.5), 'timeout')
			chatLog.text = "Starting the game... "
			yield(get_tree().create_timer(2.5), 'timeout')
			Global.introPlayed = true
			Global.scene.get_node("LEECHat").visible = true
			Global.scene.get_node("LEECHat/CanvasLayer/ColorRect").visible = true
			self.queue_free()
#		If color not in available colors, ask player to pick another one
		else:
			print('confirming player color')
			chatLog.text = "LEECH: Color " + text+ " not found. try another one please "
			return
	if playerNameSet && playerColorSet:
		yield(get_tree().create_timer(2.5), 'timeout')
	else:
		var textcolor = "#ffffff"
		if username != Global.playerName:
			textcolor = "#016d3b"
		chatLog.bbcode_text += '\n \n'
		chatLog.bbcode_text += '[color=' + textcolor + ']'
		if username != '':
			chatLog.bbcode_text += '[' + username + ']: '
		chatLog.bbcode_text += text
		chatLog.bbcode_text += '[/color]'
