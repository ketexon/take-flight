class_name Shake
extends Node


@export var _target: Node2D
@export var _amplitude: float
@export var _duration: float


func play() -> void:
	var original_position := _target.position
	
	var start_time := Time.get_ticks_msec()
	while Time.get_ticks_msec() < start_time + _duration * 1000:
		var angle := randf_range(0, 2 * PI)
		var amplitude := randf() * _amplitude
		var delta := Vector2.from_angle(angle) * amplitude
		_target.position = original_position + delta
		
		await get_tree().process_frame
	
	_target.position = original_position
