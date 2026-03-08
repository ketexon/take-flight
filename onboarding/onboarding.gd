class_name Onboarding
extends Node


@export var _dialogue: OnboardingDialogue
@export var _start_step: OnboardingStep


signal finished


func start() -> void:
	await _start_step.start(_dialogue)
	finished.emit()
