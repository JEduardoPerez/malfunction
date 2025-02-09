extends Node2D
class_name Ball


@onready var shine_timer: Timer = $ShineTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var trigger_ball: Area2D = $TriggerBall

var random_shine_time : Vector2 = Vector2(2,6)
var player : Player
var is_mouse_on_ball : bool

signal ball_thrown


func _ready() -> void:
	trigger_ball.body_entered.connect(_on_ball_body_entered)
	trigger_ball.body_exited.connect(_on_ball_body_exited)
	trigger_ball.mouse_entered.connect(_on_ball_mouse_entered)
	trigger_ball.mouse_exited.connect(_on_ball_mouse_exited)
	shine_timer.timeout.connect(_on_shine_timer_timeout)
	start_random_shine_time()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and player != null and is_mouse_on_ball: 
		throw()


func throw() -> void: 
	player.global_position = global_position + Vector2.ONE*6
	player.is_throwing = true
	ball_thrown.emit()
	queue_free()


func start_random_shine_time() -> void: 
	shine_timer.wait_time = randf_range(random_shine_time.x, random_shine_time.y)
	shine_timer.start()


func _on_shine_timer_timeout() -> void: 
	animation_player.play("shine")
	start_random_shine_time()


func _on_ball_body_entered(body : Node2D) -> void: 
	if body is Player: player = body


func _on_ball_body_exited(body : Node2D) -> void: 
	if body is Player: player = null


func _on_ball_mouse_entered() -> void: 
	is_mouse_on_ball = true


func _on_ball_mouse_exited() -> void: 
	is_mouse_on_ball = false
