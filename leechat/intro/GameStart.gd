extends Control

onready var chatLog = $boxContainer/chatLog
onready var writeLine = $boxContainer/HBoxContainer/writeLine
onready var nameLabel = $boxContainer/HBoxContainer/Label

var playerNameSet = false
var playerColorSet = false

var availableColors = ["red", "blue", "green", "yellow", "purple", "pink", "brown", "white"]
func _ready():
	chatLog.text = "LEECH: Hello! I am LEECH! To talk to your co-player, I will need your name please..."
	writeLine.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		chatLogPrint(Global.playerName, writeLine.text)
		writeLine.clear()

func chatLogPrint(username, text):
	if !playerNameSet && Global.playerName == 'Player 1':
		print('setting player name')
		Global.playerName = text
		nameLabel = Global.playerName
		chatLog.text = "LEECH confirming your name is " + Global.playerName
		return
	if !playerNameSet && Global.playerName != 'Player 1':
		print('confirming player name')
		if text == 'yes':
			playerNameSet = true
			chatLog.text = "LEECH: Name confirmed." + Global.playerName + ", What is your favorite color? "
			return
		else:
			Global.playerName = 'Player 1'
			chatLog.text = "LEECH: Name not confirmed. Please reset your name "
			return
	if playerNameSet && !playerColorSet:
		if text in availableColors:
			print('setting player color')
			chatLog.text = "LEECH: Favorite color set to " + text + " . Please wait..."
			Global.playerColor = text
			playerColorSet = true
			yield(get_tree().create_timer(2), 'timeout')
			chatLog.text = "LEECH: Starting the game... "
			yield(get_tree().create_timer(2), 'timeout')
			Global.gotoScene("res://leechat/LEECHat.tscn")
		else:
			print('confirming player color')
			chatLog.text = "LEECH: Color " + text+ " not found. try another one please "
			return
	if playerNameSet && playerColorSet:
		yield(get_tree().create_timer(1), 'timeout')
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