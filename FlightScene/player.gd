extends CharacterBody2D

@export var speed : float = 300.0
@onready var sprite = $AnimatedSprite2D
signal dead
var isDead = false
const FALL_SPEED = 300.0
const FALLING_SPRITE_SCENE = preload("res://FlightScene/FallingKing.tscn") 


func _physics_process(_delta):
	if not isDead:
	# Get input vector (left, right, up, down)
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")		# Set velocity based on direction and speed
		velocity = direction * speed
		
		# Move the character and handle collisions
		move_and_slide()


func die():
	if not isDead:
		isDead = true
		sprite.play("empy") # he so empy
		print("holy shit he dead asf fr")
		var king = FALLING_SPRITE_SCENE.instantiate()
		king.global_position = global_position
		get_tree().current_scene.add_child(king)
		dead.emit()
