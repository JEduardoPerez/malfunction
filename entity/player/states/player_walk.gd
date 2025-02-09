extends PlayerState


func enter(_previous_state : State) -> void: 
	player.play_animation("walk")
	player.set_movement_vector()


func physics_update(_delta : float) -> void:
	player.move_and_slide()
	
	if Input.is_action_just_pressed("click"): 
		player.target_location = player.get_global_mouse_position()
		state_transition.emit("walk")
	
	if player.is_fixing: state_transition.emit("fixing")
	elif player.is_throwing: state_transition.emit("throw")
	elif player.is_target_location_reached() or player.is_object_detected(): state_transition.emit("idle")
