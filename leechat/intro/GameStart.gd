extends Control

onready var chatLog = $boxContainer/chatLog
onready var writeLine = $boxContainer/HBoxContainer/writeLine
onready var nameLabel = $boxContainer/HBoxContainer/Label

var playerNameSet = false
var playerColorSet = false
func _ready():
	chatLog.text = "LEECH Hi there! I'm LEECH! To play the escape room, I'll need your name please..."
	writeLine.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		chatLogPrint(Global.playerName, writeLine.text)
		writeLine.clear()

func chatLogPrint(username, text):
	if !playerNameSet && Global.playerName == 'Player 1':
		Global.playerName = text
		nameLabel = Global.playerName
	var textcolor = "#ffffff"
	if username != Global.playerName:
		textcolor = "#016d3b"
	chatLog.bbcode_text += '\n \n'
	chatLog.bbcode_text += '[color=' + textcolor + ']'
	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'
