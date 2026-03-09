extends Control


##A reference to the child texture rect. Displays for the user to move around
@export var texture_rect :TextureRect
##The image icon for this representation
@export var texture :Texture
##The trap which will be spawned once the state_controller's scene transitions
##to spawning enemies
@export var trap_to_spawn : Resource
##This will be refunded to the player if the icon is deleted
@export var cost:int #filled when trap is spawned by UI
##Will have its signal listened for before registering the traps 
@export var _finish_button:BaseButton

signal trap_spawned(trap:Node)

var is_dragging :bool

const TILE_SIZE = Vector2(64, 64)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_dragging = false


func _spawn_trap():
	print("Spawning a disjoint trap")
	var trap = trap_to_spawn.instantiate()
	trap.position = Vector2(self.global_position)
	
	get_parent().get_parent().add_child(trap)
	print("Trap spawned. Emitting a signal for %s" % trap)
	emit_signal("trap_spawned", trap)


func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - texture_rect.size / 2
		var cell = TrapPhase.current.grid.get_cell_at_point(global_position)
		global_position = global_position.snapped(TrapPhase.current.grid.get_cell_center(cell)) 
		

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
				print('down')
				is_dragging = true
		else:
			is_dragging = false
	
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT):
		emit_signal("trap_sold", cost)
		Global.resources += cost
		print("Refunded %d gold" % cost)
		self.get_parent().queue_free.call_deferred()
