extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shake_timer: Timer = $ShakeTimer

var random_shake_time : Vector2 = Vector2(3,5)


func _ready() -> void:
	shake_timer.timeout.connect(_on_shake_timer_timeout)


func set_random_shake_time() -> void: 
	shake_timer.wait_time = randf_range(random_shake_time.x, random_shake_time.y)


func _on_shake_timer_timeout() -> void: 
	animation_player.play("shake")
	set_random_shake_time()
	shake_timer.start()
	
