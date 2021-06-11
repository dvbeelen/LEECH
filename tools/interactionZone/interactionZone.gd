extends Area

export var interaction: String
onready var chatScene = load("res://leechat/LEECHat.tscn")
var inZone = false

func _on_interactionZone_body_entered(body):
	if body.name == 'Player':
		Global.showInteractionPrompt()
		inZone = true

func _process(delta):
	if Input.is_action_just_pressed("interact") && inZone:
		match (interaction):
			'':
				pass
			'chat':
				Global.openChat()

func _on_interactionZone_body_exited(body):
	if body.name == 'Player':
		inZone = false
		Global.hideInteractionPrompt()
