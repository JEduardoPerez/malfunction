extends DogState


func enter(_previous_state : State) -> void: 
	dog.animation_player.play("idle")


func physics_update(_delta : float) -> void: 
	pass
