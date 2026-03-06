extends Node2D

@export var sprite :AnimatedSprite2D
@export var hit_box :Area2D
@export var triggered_animation :SpriteFrames
@export var triggered_animation_duration :float #how long the animation plays for
@export var cost_to_place :int #used by the shop UI
@export var num_uses :int #determines number of times a trap can be triggered
@export var trigger_delay :float #after a sprite enters the area,
								# how long until the trap triggers
								#determines when the trigger anim plays
@export var recharge_time :float #possible delay before trap can reactivate
@export var trigger_timer :float #if set, the trap will run on a timer
								#the logic will ignore recharge time if set

var enemies_in_radius = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.connect("animation_finished", Callable(self, "_on_trap_animation_finish"))

func _on_trap_animation_finishd() -> void:
	#adjust counters as necessary
	#kill off enemies in radius
	#
	for enemy in enemies_in_radius:
		if (is_instance_valid(enemy)):
			enemy.queue_free.call_deferred()
	enemies_in_radius = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_trap_hit_box_area_entered(area: Area2D) -> void:
	print("Trap area entered")
	#add logic to start the trap animation and effects
	await get_tree().create_timer(trigger_delay).timeout


#called every time an object enters the effect radius (not the trap trigger)
#if the trap effect occurs, any enemy still in the list will be deleted if valid
func _on_trap_effect_radius_area_entered(area: Area2D) -> void:
	#note that this will only delete the collision area
	#if this is not used as the root, then there will be some nodes leftover
	
	#To solve this, we could either deisgn a state controller to track objects
	#Or within the enemy class, we could add an export variable which points
	#to the root of the enemy scene. Then queue_free that instead
	enemies_in_radius[area] = null


func _on_trap_effect_radius_area_exited(area: Area2D) -> void:
	enemies_in_radius.erase(area)
