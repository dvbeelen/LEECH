extends Node

export var url = "ws://localhost:8080/"

var client = WebSocketClient.new()

func _ready():
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

func closeConn(was_clean = false):
	print("Closed: clean " + String(was_clean))
	set_process(false)

func conn(proto = ""):
	print("Connected with protocol: " + proto)

func errConn(err):
	print(err)

func onData():
	var payload = JSON.parse(client.get_peer(1).get_packet().get_string_from_utf8()).result
	print(payload)
	send()

func send():
	var payload = {
		"method": "disconnect",
		"username": "Player 1",
		"roomName": "Room1"
	}
#	var payload = {
#		"method": "chat",
#		"message": "test"
#	}
	client.get_peer(1).put_packet(JSON.print(payload).to_utf8())
