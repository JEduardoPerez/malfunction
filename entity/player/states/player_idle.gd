extends PlayerState


func enter(_previous_state : State) -> void: 
	player.play_animation("idle")


func physics_update(_delta : float) -> void:
	var click_location := player.get_click_location()
	
	if not click_location == Vector2.ZERO:
		player.target_location = click_location
		state_transition.emit("walk") 
