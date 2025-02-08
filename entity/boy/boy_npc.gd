extends CharacterBody2D
class_name BoyNPC


@onready var fsm: StateMachine = $FSM
@onready var body: Node2D = $Body
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_crying : bool
var is_celebrating : bool
