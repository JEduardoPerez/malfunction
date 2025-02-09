extends PlayerState


func enter(_previous_state : State) -> void: 
	player.animation_player.play("throw")
	if not player.animation_player.animation_finished.is_connected(_on_player_animation_finished):
		player.animation_player.animation_finished.connect(_on_player_animation_finished)


func exit() -> void: 
	player.target_location = player.global_position
	player.is_throwing = false


func _on_player_animation_finished(_animation_name: String) -> void: 
	if _animation_name == name.to_lower(): state_transition.emit("idle")
