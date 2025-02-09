extends Sprite2D


@onready var click_timer: Timer = $ClickTimer
@onready var click: ExtendedAudioStreamPlayer = $"../Click"


func _ready() -> void:
	click_timer.timeout.connect(_on_click_timer_timeout)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(_delta : float) -> void: 
	global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"): 
		click.play_at_random_pitch()
		frame = 1
		click_timer.start()


func _on_click_timer_timeout() -> void: 
	frame = 0
