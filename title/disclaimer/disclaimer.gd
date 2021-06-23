extends Control


func _ready():
	yield(get_tree().create_timer(7), 'timeout')
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicManager.toggle()
	Global.gotoScene('res://title/title.tscn')
