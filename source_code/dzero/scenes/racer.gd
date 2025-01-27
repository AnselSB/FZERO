extends CharacterBody3D


const SPEED = 500.0
const JUMP_VELOCITY = 4.5
const ACCELERATION = 0.5
const THETA =  1
const UP = Vector3(0, 1, 0)
# going to store a vector that will represent the direction of the racer, this direction will change from the directional inputs
# by default goes in direction into the screen (away from the face of the user) 
var direc = Vector3(0, 0, -1)
var initialPos = Vector3(position)
var rightTurn = Vector3(1, 0, 0)
var leftTurn = Vector3(-1, 0, 0)
# will handle all of the movement based controls for the racer, here we need to first get it to move forward, and for now we won't add gravity
func _physics_process(delta):
	# Add the gravity, may need not sure at this point	
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	if Input.is_action_pressed("gas"):
			# check for direction changes 
		if Input.is_action_pressed("left"):
		#	get the left turn (recall right hand rule)
			leftTurn = UP.cross(direc)
			# add left turn weight to the direction than normalize
			direc = direc + Vector3(leftTurn.x * 0.01, leftTurn.y * 0.01, leftTurn.z * 0.01)
			direc.normalized()
		elif Input.is_action_pressed("right"):
			# generate the right turn using the cross product (follow right hand rule), make sure to normalize
			rightTurn = direc.cross(UP)
			# add to the direction the right turn direction and normalize
			direc = direc + Vector3(rightTurn.x * 0.01, rightTurn.y * 0.01, rightTurn.z * 0.01)
			direc.normalized()
		# set velocity
		velocity.z = SPEED * delta * direc.z
		velocity.y = SPEED * delta * direc.y
		velocity.x = SPEED * delta * direc.x
	else: 
		velocity = Vector3(0, 0, 0)
	move_and_slide()
