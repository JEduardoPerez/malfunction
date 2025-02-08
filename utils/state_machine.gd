extends Node
class_name StateMachine


@export var initial_state : State

@onready var state : State = initial_state if initial_state != null else get_child(0) as State


func _ready():
	for state_node in get_children():
		if state_node is State: state_node.state_transition.connect(change_state)
	
	await owner.ready
	state.enter(null)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func change_state(new_state_path : String):
	if not has_node(new_state_path.capitalize()): print("State " + new_state_path + " doesn't exist")
	else:
		var previous_state := state
		state.exit()
		state = get_node(new_state_path.capitalize()) as State
		state.enter(previous_state)
