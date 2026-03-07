extends Node2D

@export var sprite :AnimatedSprite2D
@export var hit_box :Area2D
@export var triggered_animation :SpriteFrames
#@export var triggered_animation_duration :float #how long the animation plays for
@export var cost_to_place:int = 10 #used by the shop UI
@export var num_uses:int = -1 #determines number of times a trap can be triggered
@export var trigger_delay :float #after a sprite enters the area,
								# how long until the trap triggers
								#determines when the trigger anim plays
@export var recharge_time :float #possible delay before trap can reactivate
@export var trigger_timer :float #if set, the trap will run on a timer
								#the logic will ignore recharge time if set
var enabled = true #whether the trap is able to do trap things
var timestamp = 0
var is_triggering = false #prevents concurrent triggering

var enemies_in_radius = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timestamp = Time.get_ticks_usec()
	sprite.stop()
	#sprite.connect("animation_finished", Callable(self, "_on_trap_animation_finished"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (not enabled and Time.get_ticks_usec() > timestamp):
		print("trap re-enabled")
		enabled = true


func _on_trap_hit_box_area_entered(_area: Area2D) -> void:
	if (not enabled or is_triggering): pass
	enabled = false
	is_triggering = true
	print("Trap triggered")
	
	#add logic to start the trap animation and effects
	await get_tree().create_timer(trigger_delay).timeout
	sprite.play()
	


#called every time an object enters the effect radius (not the trap trigger)
#if the trap effect occurs, any enemy still in the list will be deleted if valid
func _on_trap_effect_radius_area_entered(area: Area2D) -> void:
	#note that this will only delete the collision area
	#if this is not used as the root, then there will be some nodes leftover
	#To solve this, we could either deisgn a state controller to track objects
	#Or within the enemy class, we could add an export variable which points
	#to the root of the enemy scene. Then queue_free that instead
	
	print("New enemy entered")
	enemies_in_radius[area] = null
	
	
func _on_trap_hit_box_body_entered(_body: Node2D) -> void:
	if (not enabled or is_triggering): pass
	enabled = false
	is_triggering = true
	print("Trap triggered")
	
	#add logic to start the trap animation and effects
	await get_tree().create_timer(trigger_delay).timeout
	sprite.play()

func _on_trap_effect_radius_area_exited(area: Area2D) -> void:
	print("Enemy left radius")
	print(enemies_in_radius.erase(area))


func _on_trap_effect_radius_body_entered(body: Node2D) -> void:
	print("New enemy entered")
	enemies_in_radius[body] = null


func _on_trap_effect_radius_body_exited(body: Node2D) -> void:
	print("Enemy left radius")
	enemies_in_radius.erase(body)


func _on_trap_sprite_animation_finished() -> void:
	#adjust counters as necessary
	#kill off enemies in radius
	print("Kills processing...")
	enabled = false
	for enemy in enemies_in_radius:
		if (is_instance_valid(enemy)):
			print("Deleting an enemy")
			enemy.queue_free.call_deferred()
	enemies_in_radius = {}
	#the trap triggered, we need to stop it from triggering again until
	#1000000 * recharge_time
	timestamp = Time.get_ticks_usec() + 1000000 * recharge_time
	num_uses -= 1
	is_triggering = false
	sprite.pause()
	if(num_uses == 0):
		self.queue_free.call_deferred()
