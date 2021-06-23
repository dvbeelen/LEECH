extends AudioStreamPlayer

#note: turn looping off after importing a sound file in godot (not needed for .wav)

var sounds_pack = {
	"buttonPress" : "res://audio/sounds/button_press.wav",
	"inputCorrect" : "res://audio/sounds/correct.wav",
	}
var muted = false

func _ready():
#	Pause node will not immediatly be set in this project.
#	pause_mode = Node.PAUSE_MODE_PROCESS
	set_volume_db(-12.0) #check master audio bus for db value

func start(name):
	if name in sounds_pack:
		stream = load(sounds_pack[name])
		if not muted:
			play()
	else:
		print("sound not found")
