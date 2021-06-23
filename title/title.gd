extends Control


func _on_exit_pressed():
	get_tree().quit()

func _on_start_pressed():
	print("Starting the game...")
#	Global.gotoScene("res://RoomA.tscn")
	Global.gotoScene("res://RoomB.tscn")
