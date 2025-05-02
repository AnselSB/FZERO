extends Camera3D


# going to try to move camera forward, that's the goal for now
var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("reverse"): 
		velocity.z = speed * delta * -1
