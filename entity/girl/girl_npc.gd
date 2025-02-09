extends CharacterBody2D
class_name GirlNPC


@export var speed : float = 24

@onready var fsm: StateMachine = $FSM
@onready var body: Node2D = $Body
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_mean : bool
var is_celebrating : bool
var is_walk : bool
var is_break : bool 

var direction : Vector2 = Vector2(0,1)


@warning_ignore("unused_signal")
signal walk_finished
@warning_ignore("unused_signal")
signal break_completed


func set_movement_vector() -> void: 
	velocity = direction * speed
