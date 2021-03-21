extends KinematicBody

#Components
onready var Camera = $camera

#Physics
var moveSpeed: float = 5.0
var gravity: float = 12.0

#Camera 
var minLookAngle: float = -90.0
var maxLookAngle: float = 90.0
var lookSensitivity : float = 10.0

#Vectors
var velocity: Vector3 = Vector3()
var mouseDeltea: Vector2 = Vector2()

func _physics_process(delta):
	velocity.x = 0
	velocity.z = 0
	
	var input = Vector2()
	
#	Movement Inputs
	if Input.is_action_just_pressed("move_forward"):
		input.y -= 1
	if Input.is_action_just_pressed("move_backward"):
		input.y += 1
	if Input.is_action_just_pressed("move_left"):
		input.x -= 1
	if Input.is_action_just_pressed("move_right"):
		input.x += 1
	
	input = input.normalized()
	
#	Get the forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
#	Set the velocity
	velocity.x = relativeDir.x * moveSpeed
	velocity.z = relativeDir * moveSpeed
	
#	Apply gravity
	velocity.y -= gravity * delta
	
#	Move the player
	velocity = move_and_slide(velocity, Vector3.UP)
