extends Control

##A reference to the sprite that contains the trigger animation.
@export var sprite :AnimatedSprite2D
##An Area2D which is responsible for detecting collisions with players and projectiles.
@export var hit_box :CollisionShape2D

##A bit janky, this moves the trap body and the hitbox
@export var moving_body :CharacterBody2D

##The number of pixels the trap will roll on the x axis in each physics tick
@export var velocity :int = 100 
var move_vector :Vector2

@export var cost:int #filled when trap is spawned by UI
								
var enabled = true #whether the trap is able to do trap things
var is_dragging = false

const TILE_SIZE = Vector2(128, 128)

signal trap_sold

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_vector = Vector2(velocity, 0)
	sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position().snapped(TILE_SIZE) + TILE_SIZE / 2.0
	else: 
		position = Vector2(moving_body.position)

func _physics_process(delta: float) -> void:
	var collision_info = moving_body.move_and_collide(move_vector * delta)
	print("Trap is moving %v. New position is %v" % [move_vector, moving_body.position])
	if collision_info:
		print("Collision occurred")
		move_vector = move_vector.bounce(collision_info.get_normal())


func _on_trap_hit_box_area_entered(area: Area2D) -> void:
	if "wall" in area.get_groups():
		self.move_vector *= -1
	else:
		area.queue_free.call_deferred()
	print("Trap triggered")
	


func _on_trap_click_box_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#if get_rect().has_point(to_local(event.position)):
				print('down')
				is_dragging = true
		else:
			is_dragging = false
	
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT):
		emit_signal("trap_sold", [cost])
		print("Refunded %d gold" %cost)
		self.queue_free.call_deferred()


func _on_trap_hit_box_body_entered(body: Node2D) -> void:
	body.queue_free.call_deferred()
