extends Spatial

export var blocked: bool

func _process(_delta):
	if $AnimationPlayer.is_playing():
		$Hinge/Cube/StaticBody/CollisionShape.disabled = true
func _on_Area_body_entered(body):
	if body.name == 'Player' && !blocked:
		$AnimationPlayer.play("Open")


func _on_Area_body_exited(body):
	if !blocked:
		$AnimationPlayer.play_backwards("Open")
