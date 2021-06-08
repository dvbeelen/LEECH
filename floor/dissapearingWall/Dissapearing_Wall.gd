extends RigidBody

onready var col = $CollisionShape

export var frame = ""

#func _process(delta):
#	if frame == Global.current_frame:
#		self.visible = false
#		col.disabled = true
#	else:
#		self.visible = true
#		col.disabled = false
