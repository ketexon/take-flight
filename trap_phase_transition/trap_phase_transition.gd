extends Node


@export var _delay := 1.0
@export var _start_animation_delay := 0.2
@export var _animation_player: AnimationPlayer
@export var _animation: StringName = &"trap_transition"
@export var _fly_away_animation: StringName = &"fly_away"
@export var _fly_away_dragon: Node2D
@export var _next_scene: PackedScene


func _ready() -> void:
	var next_scene_instance := _next_scene.instantiate()
	
	SceneTransition.instance.radius_percent = 0.0
	await get_tree().create_timer(_delay).timeout
	_animation_player.play(_animation)
	await get_tree().create_timer(_start_animation_delay).timeout
	SceneTransition.instance.transition_in()
	
	await _animation_player.animation_finished
	await get_tree().create_timer(0.5).timeout
	_animation_player.play(_fly_away_animation)
	await _animation_player.animation_finished
	
	SceneTransition.instance.follow = _fly_away_dragon
	SceneTransition.instance.transition_out()
	await SceneTransition.instance.transition_finished
	
	get_tree().change_scene_to_node(next_scene_instance)
