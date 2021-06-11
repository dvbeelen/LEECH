extends KinematicBody

#Components
onready var camera = $camera
onready var frame = $camera/CanvasLayer/Panel
onready var cameraText = $camera/CanvasLayer/cameraText

#Physics
var moveSpeed: float = 5.0
var gravity: float = 12.0

#Camera 
var minLookAngle: float = -90.0
var maxLookAngle: float = 90.0
var lookSensitivity : float = 10.0

#Vectors
var velocity: Vector3 = Vector3()
var mouseDelta: Vector2 = Vector2()

#Inner workings
var playerEnabled = true

#On start, hide the mouse
func _ready():
	cameraText.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
#	Close game if escape is pressed
	if Input.is_action_just_pressed("escape") && playerEnabled:
		get_tree().quit()
	
#	Move Camera based on mouse movement
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
#	Rotate player based on mouse movement
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	
#	Reset mouse vector
	mouseDelta = Vector2()
	
##	Reset mouse to center of screen
#	get_viewport().warp_mouse(get_viewport().size / 2)

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	
	var input = Vector2()
	
#	Movement Inputs
	if playerEnabled:
		if Input.is_action_pressed("move_forward"):
			input.y -= 1
		if Input.is_action_pressed("move_backward"):
			input.y += 1
		if Input.is_action_pressed("move_left"):
			input.x -= 1
		if Input.is_action_pressed("move_right"):
			input.x += 1
		
	input = input.normalized()
	
#	Get the forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
#	Set the velocity
	velocity.x = relativeDir.x * moveSpeed
	velocity.z = relativeDir.z * moveSpeed
	
#	Apply gravity
	velocity.y -= gravity * delta
	
#	Move the player
	velocity = move_and_slide(velocity, Vector3.UP)

func change_frame(frame_number):
	match frame_number:
		1:
			Global.red_frame = not Global.red_frame
			get_tree().get_current_scene().get_node("SubGenerator").change_story_to_show('frame1', true)
			Global.green_frame = false
			Global.blue_frame = false
			if !Global.red_frame:
				reset_frame(1)
			else:
				Global.current_frame = "red"
				color_frame(Color(1,0,0))
		2: 
			Global.green_frame = not Global.green_frame
			get_tree().get_current_scene().get_node("SubGenerator").change_story_to_show('frame2', true)
			Global.red_frame = false
			Global.blue_frame = false
			if !Global.green_frame:
				reset_frame(2)
			else:
				Global.current_frame = "green"
				color_frame(Color(0,1,0))
		3: 
			Global.blue_frame = not Global.blue_frame
			get_tree().get_current_scene().get_node("SubGenerator").change_story_to_show('frame3', true)
			Global.green_frame = false
			Global.red_frame = false
			if !Global.blue_frame:
				reset_frame(3)
			else:
				Global.current_frame = "blue"
				color_frame(Color(0,0,1))

func reset_frame(frame_to_reset):
	frame.modulate = Color(1,1,1)
	frame.modulate.a = 0
	Global.current_frame = ""
	get_tree().get_current_scene().get_node("SubGenerator").change_story_to_show('noFrame', true)
	match frame_to_reset:
		1:
			Global.red_frame = false
		2:
			Global.green_frame = false
		3:
			Global.blue_frame = false
	

func color_frame(color):
	frame.modulate = color
	frame.modulate.a = 0.5

func playerStateSwitch():
	playerEnabled = !playerEnabled
	cameraText.visible = !cameraText.visible

func showInteractionPrompt():
	cameraText.visible = true

func hideInteractionPrompt():
	cameraText.visible = false
