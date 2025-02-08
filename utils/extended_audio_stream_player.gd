extends AudioStreamPlayer
class_name ExtendedAudioStreamPlayer


@export var pitch_jitter : float = 0.1

@onready var base_pitch_scale : float = pitch_scale


func play_at_random_pitch() -> void:
	var new_pitch_scale = base_pitch_scale + [-pitch_jitter, 0, pitch_jitter].pick_random()
	pitch_scale = new_pitch_scale
	play()
