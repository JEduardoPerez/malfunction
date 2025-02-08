extends BoyState


func enter(_previous_state : State) -> void: 
	boy_npc.animation_player.play(name.to_lower())


func physics_update(_delta : float) -> void: 
	if boy_npc.is_celebrating: state_transition.emit("celebrate")
	elif boy_npc.is_crying: state_transition.emit("cry")
