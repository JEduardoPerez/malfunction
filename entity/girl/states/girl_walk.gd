extends GirlState


@export var limit_y_position : int = 108


func enter(_previous_state : State) -> void: 
	girl_npc.animation_player.play(name.to_lower())
	girl_npc.set_movement_vector()


func physics_update(_delta : float) -> void: 
	girl_npc.move_and_slide()
	if girl_npc.global_position.y >= limit_y_position: 
		girl_npc.walk_finished.emit()
		girl_npc.is_walk = false
	
	if girl_npc.is_mean: state_transition.emit("mean")
	elif girl_npc.is_celebrating: state_transition.emit("celebrate")
	elif not girl_npc.is_walk: state_transition.emit("idle")
