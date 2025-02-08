extends Node
class_name State


@warning_ignore("unused_signal")
signal state_transition(new_state_name : String)


func enter(_previous_state : State) -> void: pass


func exit() -> void: pass


func update(_delta : float) -> void: pass


func physics_update(_delta : float) -> void: pass
