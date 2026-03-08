class_name OnboardingDialogue
extends Control

@export var _label: RichTextLabel
@export var _text_frequency := 60.0
@export var _advance: OnboardingAdvanceLabel

var _cur_index := 0
var _ready_to_advance := false
var _lines: OnboardingLines

signal advanced
signal finished


func _ready() -> void:
	hide()
	await get_tree().create_timer(3).timeout


func start(lines: OnboardingLines) -> void:
	show()
	_lines = lines
	_cur_index = 0
	while _cur_index < len(_lines.lines):
		advance()
		await advanced
		_cur_index += 1
	hide()
	finished.emit()


func advance() -> void:
	_advance.hide()
	_ready_to_advance = false
	
	var text := _lines.lines[_cur_index]
	
	var interval := 1.0 / _text_frequency
	_label.visible_characters = 0
	_label.text = text
	
	var timer := Timer.new()
	timer.wait_time = interval
	timer.autostart = true
	add_child(timer)
	
	
	# shape the text
	await get_tree().process_frame
	
	while _label.visible_characters < _label.get_total_character_count():
		await timer.timeout
		_label.visible_characters += 1
	
	timer.queue_free()
	_advance.show()
	_ready_to_advance = true
	

func _gui_input(event: InputEvent) -> void:
	var mb_event := event as InputEventMouseButton
	if mb_event == null:
		return
	
	if mb_event.button_index != MOUSE_BUTTON_LEFT or not mb_event.pressed:
		return
	
	try_advance()
	accept_event()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dialogue_advance"):
		try_advance()
		accept_event()
		return


func try_advance() -> void:
	if _label.visible_characters < _label.get_total_character_count():
		_label.visible_characters = _label.get_total_character_count()
	elif _ready_to_advance:
		advanced.emit()
