extends Control
class_name ShopUI

@export var sell_trap: PackedScene
@export var trap_container: VBoxContainer
@export var _finish_button: BaseButton


var spikes_scene = preload("res://trap_phase/trap/spikes/spikes.tscn")
var arrow_shooter_scene = preload("res://trap_phase/trap/arrow/arrow_shooter.tscn")
var pressure_plate_scene = preload("res://trap_phase/trap/pressure_plate/pressure_plate.tscn")

func _ready() -> void:
	self.visible = true
	_finish_button.pressed.connect(_remove_shop)
	
	var spikes = sell_trap.instantiate()
	spikes.trap_type = spikes_scene
	spikes.trap_frame.texture = ImageTexture.create_from_image(Image.load_from_file("res://assets/traps/spikes_sm.png"))
	spikes.cost = 5
	
	var arrow_shooter = sell_trap.instantiate()
	arrow_shooter.trap_type = arrow_shooter_scene
	arrow_shooter.trap_frame.texture = ImageTexture.create_from_image(Image.load_from_file("res://assets/traps/loadedarrow_sm.png"))
	arrow_shooter.cost = 10
	
	var plate = sell_trap.instantiate()
	plate.trap_type = spikes_scene
	
	trap_container.add_child(spikes)
	trap_container.add_child(arrow_shooter)
	#trap_container.add_child(plate)
	

func _remove_shop():
	self.queue_free.call_deferred()
