extends DogState


func enter(_previous_state : State) -> void: 
	dog.animation_player.play("run")


func physics_update(_delta : float) -> void: 
	if dog.is_intro_scenes: return
	dog.move()
	
	if dog.is_target_location_reached() and dog.is_final_activated: state_transition.emit("final")
	elif dog.is_target_location_reached(): state_transition.emit("idle")
