class_name ModalWiggle
extends Control


@export var _frequency := Vector2(3.5, 2.95)
@export var _amplitude := Vector2(3, 3)

var _start_position: Vector2
var _set_start_position := false

func _process(_delta: float) -> void:
	if not _set_start_position:
		_start_position = position
		_set_start_position = true
	
	var time_sec := Time.get_ticks_msec() / 1000.0
	position = Vector2(
		cos(_frequency.x * time_sec),
		sin(_frequency.y * time_sec),
	) * _amplitude + _start_position
