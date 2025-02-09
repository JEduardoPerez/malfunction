extends GirlState


func enter(_previous_state : State) -> void: 
	girl_npc.animation_player.play(name.to_lower())
	if not girl_npc.animation_player.animation_finished.is_connected(_on_animation_player_finished): 
		girl_npc.animation_player.animation_finished.connect(_on_animation_player_finished)


func exit() -> void: 
	girl_npc.break_completed.emit()


func physics_update(_delta : float) -> void: 
	if girl_npc.is_celebrating: state_transition.emit("celebrate")
	elif girl_npc.is_walk: state_transition.emit("walk")
	elif girl_npc.is_mean: state_transition.emit("mean")
	elif not girl_npc.is_break: state_transition.emit("idle")


func _on_animation_player_finished(_animation_name : String) -> void: 
	if _animation_name == name.to_lower(): 
		girl_npc.is_break = false
