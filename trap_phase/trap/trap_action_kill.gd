class_name TrapActionKill
extends TrapAction


func activate(character: TrapPhaseCharacter) -> void:
	character.kill()
