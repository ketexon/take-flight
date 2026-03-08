extends Control
class_name ShopUI

@export var sell_trap: PackedScene
@export var trap_container: VBoxContainer
@export var _finish_button: BaseButton


var representation = preload("res://ui/trap_representations/trap_representation.tscn")
var disjoint_representation = preload("res://ui/trap_representations/disjoint_trap_representation.tscn")


var spikes_scene = preload("res://trap_phase/trap/spikes/spikes.tscn")
var arrow_shooter_scene = preload("res://trap_phase/trap/arrow/arrow_shooter.tscn")
var pressure_plate_scene = preload("res://trap_phase/trap/pressure_plate/pressure_plate.tscn")

func _ready() -> void:
	self.visible = true
	_finish_button.pressed.connect(_remove_shop)
	
	var spikes = sell_trap.instantiate()
	spikes.representation = representation
	spikes._finish_button = _finish_button
	spikes.trap_type = spikes_scene
	spikes.trap_frame.texture = ImageTexture.create_from_image(Image.load_from_file("res://assets/traps/spikes_sm.png"))
	spikes.cost = 5
	#
	var arrow_shooter = sell_trap.instantiate()
	arrow_shooter.representation = disjoint_representation
	arrow_shooter.disjoint_trigger_object = pressure_plate_scene
	arrow_shooter._finish_button = _finish_button
	arrow_shooter.trap_type = arrow_shooter_scene
	arrow_shooter.trap_frame.texture = ImageTexture.create_from_image(Image.load_from_file("res://assets/traps/loadedarrow_sm.png"))
	arrow_shooter.cost = 10
	

	trap_container.add_child(spikes)
	trap_container.add_child(arrow_shooter)
	

func _remove_shop():
	self.queue_free.call_deferred()
