extends Control

var insertedCode = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	for button in get_tree().get_nodes_in_group("numberKeys"):
		button.connect("pressed", self, "pressNumber", [button.name])

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		Global.removeInteractableFromCamera(self.name)
		Global.playerStateSwitch()

func pressNumber(numberPressed):
	print('number inserted: ' + String(numberPressed))
	$display.text = $display.text + numberPressed
	insertedCode.append(numberPressed)
	if insertedCode.size() >= 4:
		checkCode()

func checkCode():
	print(insertedCode)
	if insertedCode == Global.doorCode:
		print('right code')
		$display.text = 'CODE CORRECT'
		yield(get_tree().create_timer(1.5), 'timeout')
		Global.doorUnlocked = true
	else:
		print('wrong code')
		yield(get_tree().create_timer(0.5), 'timeout')
		$display.text = 'CODE INCORRECT'
		yield(get_tree().create_timer(1.5), 'timeout')
		$display.text = ''
		insertedCode = []
