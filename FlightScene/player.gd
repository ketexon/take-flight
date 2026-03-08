extends CharacterBody2D

@export var speed : float = 300.0
signal dead

func _physics_process(_delta):
	# Get input vector (left, right, up, down)
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Set velocity based on direction and speed
	velocity = direction * speed
	
	# Move the character and handle collisions
	move_and_slide()


func die():
	print("holy shit he dead asf fr")
	dead.emit()
