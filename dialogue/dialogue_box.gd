extends CanvasLayer


@export var portrait_dad : Texture
@export var portrait_boy : Texture
@export var portrait_boy_happy : Texture

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var display_label: Label = $TextureRect/MarginContainer/DisplayLabel
@onready var character_timer: Timer = $CharacterTimer
@onready var texture_rect: TextureRect = $TextureRect/MarginContainer/MarginContainer/TextureRect

var dialogue_array : Array[String]

var is_dialogue_active : bool

signal dialogue_completed


func _ready() -> void:
	character_timer.timeout.connect(_on_character_timer_timeout)


func _process(_delta: float) -> void:
	if is_dialogue_active and not animation_player.is_playing() and Input.is_action_just_pressed("click"):
		if character_timer.is_stopped(): next_line()
		else:
			character_timer.stop()
			display_label.visible_ratio = 1


func start_new_dialogue(_dialogue_array : Array[String], portrait : Texture = portrait_dad) -> void: 
	dialogue_array = _dialogue_array
	texture_rect.texture = portrait
	open_dialogue()


func next_line() -> void: 
	if dialogue_array.size() > 0: 
		display_label.text = dialogue_array.pop_front()
		display_label.visible_ratio = 0
		character_timer.start()
	else:
		display_label.text = "" 
		close_dialogue()


func open_dialogue() -> void: 
	is_dialogue_active = true
	dialogue_in()
	await animation_player.animation_finished
	next_line()


func close_dialogue() -> void:
	dialogue_out()
	await animation_player.animation_finished
	is_dialogue_active = false
	dialogue_completed.emit()


func dialogue_in() -> void: 
	animation_player.play("dialogue_in")


func dialogue_out() -> void: 
	animation_player.play("dialogue_out")


func _on_character_timer_timeout() -> void: 
	if display_label.visible_ratio < 1: display_label.visible_characters += 1
	else: character_timer.stop()
