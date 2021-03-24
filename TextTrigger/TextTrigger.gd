extends Spatial

func _on_area_body_entered(body):
	if body is KinematicBody:
		print('area entered')


func _on_area_body_exited(body):
	if body is KinematicBody:
		print('area left')
