extends Node


@export var _player: FlightPlayer
@export var _transition_delay_time := 1.0
@export_file("*.tscn") var _trap_scene: String


func _ready() -> void:
	SceneTransition.instance.transition_in()
	await _player.dead
	await get_tree().create_timer(_transition_delay_time).timeout
	SceneTransition.instance.transition_out()
	await SceneTransition.instance.transition_finished
	get_tree().change_scene_to_file(_trap_scene)
