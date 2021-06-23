extends Area

func _on_endingBox_body_entered(body):
	if body.name == 'Player':
		print('ending entered')
		Global.gotoScene('res://title/endingScreen/ending.tscn')

