extends CharacterBody3D

@export var SPEED : float = 10.00

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(_delta):
	var input_dir = Input.get_vector("left", "right","up","down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
#		velocity.x = move_toward(velocity.x, 0, delta)
#		velocity.z = move_toward(velocity.z, 0, delta)
		velocity.x = 0
		velocity.z = 0
	
	move_and_slide()
