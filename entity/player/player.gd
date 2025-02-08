extends CharacterBody2D
class_name Player


@onready var fsm: StateMachine = $FSM
@onready var body: Node2D = $Body
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var object_detector: RayCast2D = $ObjectDetector

@export var speed : float = 48
@export var object_detector_length : float = 24

var direction : Vector2 : set = set_direction
var target_location : Vector2 : set = set_target_location




func get_click_location() -> Vector2: 
	return get_global_mouse_position() if Input.is_action_just_pressed("click") else Vector2.ZERO


func set_movement_vector() -> void: 
	velocity = direction * speed


func set_direction(new_direction : Vector2) -> void: 
	direction = new_direction
	object_detector.target_position = direction.normalized() * object_detector_length


func set_target_location(new_target_location : Vector2) -> void: 
	target_location = new_target_location
	direction = global_position.direction_to(target_location)


func is_object_detected() -> bool: 
	return object_detector.is_colliding()


func is_target_location_reached() -> bool: 
	return abs(global_position.length() - target_location.length()) < 1


func play_animation(animation_name : String) -> void:
	var animation_name_direction := animation_name + ("_up" if direction.y < 0 else "_down")
	animation_player.play(animation_name_direction)
