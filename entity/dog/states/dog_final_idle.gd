extends DogState


func enter(_previous_state : State) -> void: 
	dog.animation_player.play("idle_final")
	dog.body.scale.x = 1
	dog.dog_drop_piece.emit()
