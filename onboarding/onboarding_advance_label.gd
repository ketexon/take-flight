class_name OnboardingAdvanceLabel
extends Control


@export var _blink_interval := 1.5

var _tween: Tween

func _ready() -> void:
	_tween = create_tween()
	_tween.set_loops()
	_tween.set_trans(Tween.TRANS_CUBIC)
	_tween.set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "modulate:a", 1.0, _blink_interval / 2)
	_tween.set_ease(Tween.EASE_IN)
	_tween.tween_property(self, "modulate:a", 0.0, _blink_interval / 2)
	
	if not visible:
		_tween.stop()
	
	visibility_changed.connect(_on_visibility_changed)
	

func _on_visibility_changed() -> void:
	if visible:
		_tween.play()
	else:
		_tween.stop()
	
