extends Sprite2D
class_name Explanatory


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shake_timer: Timer = $ShakeTimer
@onready var swing_sfx: ExtendedAudioStreamPlayer = $SwingSFX

signal shake_completed
var target_distance := 2
var last_target_distance := 0
var target_shakes := 5
var current_shakes := 0

var is_side : bool
var is_repair_mode: bool


func _ready() -> void:
	shake_timer.timeout.connect(_on_shake_timer_timeout)


func _process(_delta: float) -> void:
	if animation_player.is_playing(): 
		if animation_player.current_animation == "sides": is_side = true
		else: is_side = false


func _input(event: InputEvent) -> void:
	if not animation_player.is_playing(): return
	if event is InputEventMouseMotion: 
		var x_relative = event.relative.x
		var y_relative = event.relative.y
		
		if is_side: 
			if (last_target_distance < 0 and x_relative > target_distance) or (last_target_distance == 0 and x_relative > target_distance):
				shake_timer.start()
				current_shakes +=1
				last_target_distance = 1
				swing_sfx.play_at_random_pitch()
			elif (last_target_distance > 0 and x_relative < -target_distance) or (last_target_distance == 0 and x_relative < -target_distance):
				shake_timer.start()
				current_shakes +=1
				last_target_distance = -1
				swing_sfx.play_at_random_pitch()
		else:
			if (last_target_distance < 0 and y_relative > target_distance) or (last_target_distance == 0 and y_relative > target_distance):
				shake_timer.start()
				current_shakes +=1
				last_target_distance = 1
				swing_sfx.play_at_random_pitch()
			elif (last_target_distance > 0 and y_relative < -target_distance) or (last_target_distance == 0 and y_relative < -target_distance):
				shake_timer.start()
				current_shakes +=1
				last_target_distance = -1
				swing_sfx.play_at_random_pitch()

	if current_shakes >= target_shakes: 
		shake_completed.emit()
		set_process_input(false)


func play_sides() -> void: 
	if not is_repair_mode:
		animation_player.play("sides")


func play_vertical() -> void: 
	if not is_repair_mode: 
		animation_player.play("vertical")


func stop_animation() -> void: 
	if animation_player.is_playing():
		animation_player.play("stop")


func _on_shake_timer_timeout() -> void: 
	current_shakes = 0
