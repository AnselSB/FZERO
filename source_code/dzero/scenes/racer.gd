extends CharacterBody3D

@export var rotSpeed : float = PI * 4 
var theta = 0
 
const SPEED = 1000.0
const ACCELERATION = 0.5
const UP = Vector3(0, 1, 0)
# going to store a vector that will represent the direction of the racer, this direction will change from the directional inputs
# by default goes in direction into the screen (away from the face of the user) 
var direc = Vector3(0, 0, -1)
var initialPos = Vector3(position)
var rightTurn = Vector3(1, 0, 0)
var leftTurn = Vector3(-1, 0, 0)
var friction = 0.3
var accel = 0.08

func _ready(): 
	set_rotation(Vector3(0, -1*PI, 0))

# will handle all of the movement based controls for the racer
func _physics_process(delta):
	
	
	if Input.is_action_pressed("gas"):
		# check for direction changes 
		if Input.is_action_pressed("left"):
			
		#	get the left turn (recall right hand rule)
			leftTurn = UP.cross(direc)
			# add left turn weight to the direction than normalize
			direc = direc + Vector3(leftTurn.x * 0.01, leftTurn.y * 0.01, leftTurn.z * 0.01)
			direc.normalized()
			theta = wrapf(atan2(direc.x, direc.z) - rotation.y, -PI, PI)
			set_rotation(Vector3(0, rotation.y + clamp(rotSpeed * delta, 0, abs(theta)) * sign(theta), 0))
			$CameraController.rotation.y += clamp(rotSpeed * delta, 0, abs(theta)) * sign(theta)
		elif Input.is_action_pressed("right"):
			# generate the right turn using the cross product (follow right hand rule), make sure to normalize
			rightTurn = direc.cross(UP)
			# add to the direction the right turn direction and normalize
			direc = direc + Vector3(rightTurn.x * 0.01, rightTurn.y * 0.01, rightTurn.z * 0.01)
			direc.normalized()
			# this will be for calculating the angle at which the model should rotate so that the spirte is facing the direction it's moving
			# set the theta first 
			theta = wrapf(atan2(direc.x, direc.z) - rotation.y, -PI, PI)
			set_rotation(Vector3(0, rotation.y + clamp(rotSpeed * delta, 0, abs(theta)) * sign(theta), 0))
			$CameraController.rotation.y += clamp(rotSpeed * delta, 0, abs(theta)) * sign(theta)
		
		
		# set velocity
		velocity.z = move_toward(velocity.z, SPEED * delta * direc.z, accel)
		velocity.y = move_toward(velocity.y, SPEED * delta * direc.y, accel)
		velocity.x = move_toward(velocity.x, SPEED * delta * direc.x, accel)
	else: 
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.y = move_toward(velocity.y, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)
	move_and_slide()
	# the following is for ensuring the camera controller position to be the same to the racer's 
	$CameraController.position = lerp($CameraController.position, position, 0.75)
	
