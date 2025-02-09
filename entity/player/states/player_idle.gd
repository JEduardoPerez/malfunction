extends PlayerState


func enter(_previous_state : State) -> void: 
	player.play_animation("idle")


func physics_update(_delta : float) -> void:
	if Input.is_action_just_pressed("click"): player.target_location = player.get_global_mouse_position()
	
	if not player.is_target_location_reached() and not player.is_object_detected(): state_transition.emit("walk") 
