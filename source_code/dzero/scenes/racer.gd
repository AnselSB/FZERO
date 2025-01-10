extends CharacterBody3D


const SPEED = 100.0
const JUMP_VELOCITY = 4.5
const ACCELERATION = 0.5
const THETA =  1
# going to store a vector that will represent the direction of the racer, this direction will change from the directional inputs
# by default goes in direction into the screen (away from the face of the user) 
var direc = Vector3(0, 0, -1)
var initialPos = Vector3(position)
# will handle all of the movement based controls for the racer, here we need to first get it to move forward, and for now we won't add gravity
func _physics_process(delta):
	# Add the gravity, may need not sure at this point	
	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	if Input.is_action_pressed("gas"):
			# check for direction changes 
		if Input.is_action_pressed("left"):
		# when going left we want to have the object slowly turn to the left, this will involve rotating the direction clockwise about the y axis
		# also need to normalize the vector 
			direc = direc.rotated(Vector3(0, 1, 0),THETA * delta)
			self.rotate_y(THETA * delta)
			direc.normalized()
	# repeat for the other direction, elif because we don't want to be able to go left and right simultaneously 
		elif Input.is_action_pressed("right"):
			direc = direc.rotated(Vector3(0, 1, 0), -1 * THETA * delta)
			self.rotate_y(THETA * delta)
			direc.normalized()
		#add to the position the speed in the direction of the racer multiplied by the delta
		# we'll want to create a "limit" to the velocity, if the magnitude is a certain speed it no longer gets faster
		if velocity.length() < 25:
			velocity.z += SPEED * delta * direc.z * ACCELERATION 
			velocity.y += SPEED * delta * direc.y  * ACCELERATION
			velocity.x += SPEED * delta * direc.x  * ACCELERATION
	else: 
		velocity = Vector3(0, 0, 0)
	move_and_slide()
