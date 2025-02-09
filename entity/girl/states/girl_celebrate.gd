extends GirlState


func enter(_previous_state : State) -> void: 
	girl_npc.animation_player.play(name.to_lower())


func exit() -> void: 
	girl_npc.is_celebrating = false


func physics_update(_delta : float) -> void: 
	if girl_npc.is_mean: state_transition.emit("mean")
	elif girl_npc.is_walk: state_transition.emit("walk")
	elif not girl_npc.is_celebrating: state_transition.emit("idle")
