extends CharacterBody2D
class_name Player


@onready var fsm: StateMachine = $FSM
@onready var body: Node2D = $Body
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var object_detector: RayCast2D = $ObjectDetector
@onready var object_detector_2: RayCast2D = $ObjectDetector2
@onready var object_detector_3: RayCast2D = $ObjectDetector3

@export var speed : float = 48
@export var object_detector_length : float = 12

var direction : Vector2 : set = set_direction
var target_location : Vector2 : set = set_target_location


func _ready() -> void:
	target_location = global_position


func set_movement_vector() -> void: 
	velocity = direction * speed


func set_direction(new_direction : Vector2) -> void: 
	direction = new_direction
	object_detector.target_position = direction.normalized() * object_detector_length
	object_detector_2.target_position = direction.normalized() * (object_detector_length-4)
	object_detector_3.target_position = direction.normalized() * (object_detector_length-4)


func set_target_location(new_target_location : Vector2) -> void: 
	target_location = new_target_location
	direction = global_position.direction_to(target_location)


func is_object_detected() -> bool: 
	return object_detector.is_colliding() or object_detector_2.is_colliding() or object_detector_3.is_colliding()


func is_target_location_reached() -> bool: 
	return abs(global_position.length() - target_location.length()) < 1


func play_animation(animation_name : String) -> void:
	var animation_name_direction := animation_name + ("_up" if direction.y < 0 else "_down")
	animation_player.play(animation_name_direction)
