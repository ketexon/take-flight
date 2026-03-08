class_name SceneTransition
extends CanvasItem

static var instance: SceneTransition = null

@export var _duration: float = 1
@export var _follow: Node2D

var center: Vector2 = Vector2.ZERO:
	set(v):
		center = v
		_shader_material.set_shader_parameter(&"center_px", center)


var radius_percent: float = 0:
	set(v):
		radius_percent = v
		_shader_material.set_shader_parameter(&"radius_percent", radius_percent)


var _shader_material: ShaderMaterial


signal transition_finished


func _ready() -> void:
	assert(material is ShaderMaterial)
	_shader_material = material as ShaderMaterial
	
	radius_percent = 0


func _enter_tree() -> void:
	instance = self
	
	
func _exit_tree() -> void:
	if instance == self:
		instance = null


func transition_out() -> void:
	transition(1.0, 0.0)


func transition_in() -> void:
	transition(0.0, 1.0)
	

func transition(from: float, to: float) -> void:
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	radius_percent = from
	tween.tween_property(self, "radius_percent", to, _duration)
	await tween.finished
	transition_finished.emit()


func _process(_delta: float) -> void:
	if _follow:
		var xform := get_viewport().canvas_transform
		center = xform * _follow.global_position
