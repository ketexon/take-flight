class_name OnboardingStep
extends Control

@export var _lines: OnboardingLines
@export var _next: OnboardingStep
@export var _grow_horizontal: GrowDirection
@export var _grow_vertical: GrowDirection


func start(dialogue: OnboardingDialogue) -> void:
	dialogue.reparent(self, false)
	
	dialogue.grow_horizontal = _grow_horizontal
	dialogue.grow_vertical = _grow_vertical
	
	dialogue.anchor_bottom = 0
	dialogue.anchor_left = 0
	dialogue.anchor_right = 0
	dialogue.anchor_top = 0

	dialogue.offset_bottom = 0
	dialogue.offset_left = 0
	dialogue.offset_right = 0
	dialogue.offset_top = 0
	
	await dialogue.start(_lines)
	if _next != null:
		await get_tree().process_frame
		await _next.start(dialogue)
