extends Node

var TextDisplay = preload("res://TextTrigger/TextDisplay.tscn")

func _ready():
	#Open File and get all lines
	var data_file = File.new()
	if data_file.open("res://BookImport/TYW_Chapter_1.json", File.READ) != OK:
		print('file could not be read')
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		print('file does not contain valid JSON')
		return
	var data = data_parse.result
	if data:
		generateEnvironmentalSubtitles(data)

func generateEnvironmentalSubtitles(data):
	var keys = data.text.keys()
	var lines = data.text.values()
	for i in data.text.size():
		var subtitle = TextDisplay.instance()
		subtitle.get_node("Viewport/Control/Label").text = lines[i]
		subtitle.name = keys[i]
		self.add_child(subtitle)
