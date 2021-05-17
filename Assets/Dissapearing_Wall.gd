extends RigidBody

onready var col = $CollisionShape

export var frame = 1

func _process(delta):
	if Global.red_frame == true:
		self.visible = false
		col.disabled = true
	else:
		self.visible = true
		col.disabled = false
