extends Spatial

func _process(delta):
	if Global.introPlayed && !Global.door2opened:
		$Assets/Room/Doors/Door2.open()
		Global.door2opened = true
	if Global.introPlayed && !Global.door1opened && Global.tutorialEndReached:
		$Assets/Room/Doors/Door.open()
		Global.door1opened = true
