extends Spatial

export var blocked: bool

func _process(_delta):
	if $AnimationPlayer.is_playing():
		$Hinge/Cube/StaticBody/CollisionShape.disabled = true

func open():
	$AnimationPlayer.play("Open")

