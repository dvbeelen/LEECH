extends AudioStreamPlayer

var sounds_pack = {
#	"name of the sound" : "res: path to the sound"
	"BackgroundMusic": "res://audio/music/LEECH_soundtrack.wav",
	}
	
var muted = false
var nowPlaying = ""
var pausedOn = 0

func _ready():
	set_volume_db(-30.0)
	print(muted)

func start(name):
	if name in sounds_pack && nowPlaying != name:
		stream = load(sounds_pack[name])
		if not muted:
			play()
			nowPlaying = name
	
func toggle():
	muted = !muted
	if muted:
		pausedOn = get_playback_position ()
		stop()
	else:
		play(pausedOn)
		pausedOn = 0
