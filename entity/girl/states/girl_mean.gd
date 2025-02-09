extends GirlState


func enter(_previous_state : State) -> void: 
	girl_npc.animation_player.play(name.to_lower())


func exit() -> void: 
	girl_npc.is_mean = false


func physics_update(_delta : float) -> void: 
	if girl_npc.is_celebrating: state_transition.emit("celebrate")
	elif girl_npc.is_walk: state_transition.emit("walk")
	elif girl_npc.is_break: state_transition.emit("break")
	elif not girl_npc.is_mean: state_transition.emit("idle")
