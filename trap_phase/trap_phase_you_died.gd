class_name TrapPhaseYouDied
extends Control

@export var _button: BaseButton
@export_file("*.tscn") var _menu_scene_path: String

func _ready() -> void:
	_button.pressed.connect(_on_back_to_menu_pressed)
	

func fade_in() -> void:
	show()
	modulate.a = 0
	var tween := create_tween()
	tween.tween_interval(1)
	tween.tween_property(self, "modulate:a", 1, 0.2)


func _on_back_to_menu_pressed() -> void:
	SceneTransition.instance.transition_out()
	await SceneTransition.instance.transition_finished
	get_tree().change_scene_to_file(_menu_scene_path)
