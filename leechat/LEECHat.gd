extends Control

export var url = "ws://localhost:8080/"

var client = WebSocketClient.new()
onready var chatLog = $boxContainer/chatLog
onready var writeLine = $boxContainer/HBoxContainer/writeLine
onready var nameLabel = $boxContainer/HBoxContainer/playerName
onready var characterCount = $boxContainer/HBoxContainer/characterCount
var enteredTextSize = 0

func _ready():
	chatLog.get_child(0).rect_scale.x = 0
	characterCount.text = String(Global.maxCharactersForChat)
	writeLine.max_length = Global.maxCharactersForChat
	writeLine.grab_focus()
	client.connect("connection_closed", self, "closeConn")
	client.connect("connection_error", self, "errConn")
	client.connect("connection_established", self, "conn")
	client.connect("data_received", self, "onData")
	
	var err = client.connect_to_url(url)
	if err != OK:
		print("Unable to connect.")
		set_process(false)

func _process(_delta):
	client.poll()
	if Input.is_action_just_pressed("enter"):
		var nPayload = {
			"method": "chat",
			"username": Global.playerName,
			"message": writeLine.text
		}
		writeLine.clear()
		send(nPayload)

func closeConn(was_clean = false):
	print("Closed: clean " + String(was_clean))
	set_process(false)

func conn(proto = ""):
	print("Connected with protocol: " + proto)

func errConn(err):
	print(err)

func onData():
	var payload = JSON.parse(client.get_peer(1).get_packet().get_string_from_utf8()).result
	if payload.method == "chat":
		chatLogPrint(payload.username, String(payload.message))

func send(payload):
	client.get_peer(1).put_packet(JSON.print(payload).to_utf8())
	characterCount.text = String(Global.maxCharactersForChat)

func chatLogPrint(username, text):
	var textcolor = Global.playerColor
	if username != Global.playerName:
		textcolor = "#016d3b"
	chatLog.bbcode_text += '\n \n'
	chatLog.bbcode_text += '[color=' + textcolor + ']'
	if username != '':
		chatLog.bbcode_text += '[' + username + ']: '
	chatLog.bbcode_text += text
	chatLog.bbcode_text += '[/color]'


func _on_writeLine_text_changed(new_text):
	var charLeft = int(characterCount.text)
	charLeft -= 1
	characterCount.text = String(charLeft)
