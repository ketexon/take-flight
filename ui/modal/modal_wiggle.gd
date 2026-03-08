class_name ModalWiggle
extends Control


@export var _frequency := Vector2(3.5, 2.95)
@export var _amplitude := Vector2(3, 3)


func _process(_delta: float) -> void:
	var time_sec := Time.get_ticks_msec() / 1000.0
	position = Vector2(
		cos(_frequency.x * time_sec),
		sin(_frequency.y * time_sec),
	) * _amplitude
