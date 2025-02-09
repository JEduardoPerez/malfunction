extends DogState


func enter(_previous_state : State) -> void: 
	if not dog.is_intro_scenes: 
		dog.animation_player.play("idle")
		dog.idle_timer.start()
	else:
		dog.animation_player.play("idle_final")


func physics_update(_delta : float) -> void: 
	if dog.is_intro_scenes: return
	
	if not dog.is_target_location_reached(): state_transition.emit("run")
