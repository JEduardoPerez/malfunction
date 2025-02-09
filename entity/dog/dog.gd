extends CharacterBody2D
class_name Dog


@export var is_intro_scenes : bool
@export var target_locations : Array[Marker2D]
@export var final_target_location : Marker2D

@export var speed : int = 48

@onready var fsm: StateMachine = $FSM
@onready var body: Node2D = $Body
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var idle_timer: Timer = $IdleTimer

var target_location : Vector2
var is_final_activated : bool

@warning_ignore("unused_signal")
signal dog_drop_piece

func _ready() -> void:
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	target_location = global_position


func move() -> void: 
	velocity = global_position.direction_to(target_location) * speed
	move_and_slide()


func set_new_target_location() -> void: 
	while is_target_location_reached(): 
		target_location = target_locations.pick_random().global_position
	body.scale.x = sign(target_location.x - global_position.x)


func set_final_target_location() -> void: 
	is_final_activated = true
	target_location = final_target_location.global_position
	body.scale.x = sign(target_location.x - global_position.x)


func is_target_location_reached() -> bool: 
	return abs(global_position.length() - target_location.length()) < 1


func _on_idle_timer_timeout() -> void: 
	set_new_target_location()
