extends Node


@export var _delay := 1.0
@export var _start_animation_delay := 0.2
@export var _animation_player: AnimationPlayer
@export var _animation: StringName = "trap_transition"


func _ready() -> void:
	SceneTransition.instance.radius_percent = 0.0
	await get_tree().create_timer(_delay).timeout
	_animation_player.play(_animation)
	await get_tree().create_timer(_start_animation_delay).timeout
	SceneTransition.instance.transition_in()
