extends Control

@export var texture :Texture
@export var draggable_trap :Control
@export var draggable_trigger :Control

##The trap which will be spawned once the state_controller's scene transitions
##to spawning enemies
@export var trap_to_spawn : Resource
##The scene which will be spawned and linked to the trap_to_spawn 
@export var disjoint_trigger_to_spawn :Resource
##The movable representation of the object which will trigger the trap
@export var trigger_representation :Resource
##This will be refunded to the player if the icon is deleted
@export var cost:int #filled when trap is spawned by UI
##Will have its signal listened for before registering the traps 
@export var _finish_button:BaseButton

const TILE_SIZE = Vector2(64, 64)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draggable_trap.texture = texture
	draggable_trap.texture_rect.texture = texture
	draggable_trap.trap_to_spawn = trap_to_spawn
	draggable_trap.cost = cost
	draggable_trap._finish_button = _finish_button
	draggable_trap._finish_button.pressed.connect(draggable_trap._spawn_trap)
	
	
	draggable_trigger.cost = cost
	draggable_trigger._finish_button = _finish_button
	draggable_trigger._finish_button.pressed.connect(draggable_trigger._spawn_trap)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
