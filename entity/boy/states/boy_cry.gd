extends BoyState


func enter(_previous_state : State) -> void: 
	boy_npc.animation_player.play(name.to_lower())


func exit() -> void: 
	boy_npc.is_crying = false


func physics_update(_delta : float) -> void: 
	if boy_npc.is_celebrating: state_transition.emit("celebrate")
	elif not boy_npc.is_crying: state_transition.emit("idle")
