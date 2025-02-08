extends PlayerState


func enter(_previous_state : State) -> void: 
	player.play_animation("walk")
	player.set_movement_vector()


func physics_update(_delta : float) -> void:
	var click_location := player.get_click_location()
	if not click_location == Vector2.ZERO: 
		player.target_location = click_location
		enter(self)
	 
	player.move_and_slide()
	
	if player.is_target_location_reached(): state_transition.emit("idle")
