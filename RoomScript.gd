extends Spatial

func _ready():
	MusicManager.start('BackgroundMusic')

func _process(delta):
	if Global.introPlayed && !Global.door2opened:
		$Assets/Room/Doors/Door2.open()
		Global.door2opened = true
	if Global.introPlayed && !Global.door1opened && Global.tutorialEndReached:
		$Assets/Room/Doors/Door.open()
		Global.door1opened = true
	if Global.doorUnlocked && !Global.door3opened:
		print('open door')
		$Assets/Room/Doors/Door3.open()
		Global.door3opened = true
