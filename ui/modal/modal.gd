class_name Modal
extends Control


static var instance: Modal = null


@export var _move_in_duration := 0.2
@export var _stay_duration := 2

@export var _heading_label: Label
@export var _description_label: Label


var _tween: Tween = null


signal finished


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	if instance == self:
		instance = null


func show_modal(heading: String, description: String) -> void:
	if visible:
		await finished
	
	_heading_label.text = heading
	_description_label.text = description
	show()
	if _tween != null:
		_tween.kill()
		_tween = null
	
	position.x = -get_viewport_rect().size.x
	
	_tween = create_tween()
	
	_tween.set_ease(Tween.EASE_OUT)
	_tween.set_trans(Tween.TRANS_BACK)
	
	_tween.tween_property(
		self,
		"position:x",
		0.0,
		_move_in_duration
	)
	_tween.tween_interval(_stay_duration)
	
	_tween.set_ease(Tween.EASE_IN)
	_tween.tween_property(
		self,
		"position:x",
		get_viewport_rect().size.x,
		_move_in_duration
	)
	await _tween.finished
	hide()
	finished.emit()
