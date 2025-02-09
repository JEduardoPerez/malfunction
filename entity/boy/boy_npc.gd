extends CharacterBody2D
class_name BoyNPC


@onready var fsm: StateMachine = $FSM
@onready var body: Node2D = $Body
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var jump: ExtendedAudioStreamPlayer = $SFXs/Jump


var is_crying : bool
var is_celebrating : bool


func _process(delta: float) -> void:
	if jump.playing and jump.get_playback_position() >= 0.18: jump.stop()
