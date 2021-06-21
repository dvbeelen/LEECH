extends Control

onready var chatLog = $boxContainer/chatLog
onready var writeLine = $boxContainer/HBoxContainer/writeLine
onready var nameLabel = $boxContainer/HBoxContainer/Label


var hints = [
	'Look closely at the paintings, see any symbols on them?',
	'Maybe your co-player knows more about the symbols on the walls...',
	'You will need 4 numbers to escape, 2 from your room, 2 from your co-players',
	'Look at the green house',
	'Look in the lake',
	'Look at the top-left tree',
	'Look at the right in the sky above the mountains',
	'The correct order is house, tree, mountain, lake'
]
