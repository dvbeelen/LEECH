extends RigidBody

export var frame = 1


func _process(delta):
	if Global.red_frame == true:
		self.visible = false
	else:
		self.visible = true
