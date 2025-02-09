extends DogState


func enter(_previous_state : State) -> void: 
	dog.animation_player.play("run")


func physics_update(_delta : float) -> void: 
	pass
