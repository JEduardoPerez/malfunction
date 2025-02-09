extends CanvasLayer
class_name FadingUILayer

@onready var color_rect: ColorRect = $ColorRect

@export var fade_length : float = 0.64


func _ready() -> void:
	color_rect.color.a = 0


func fade_in() -> Tween: 
	var tween := create_tween()
	color_rect.color = Color(0,0,0,0)
	tween.tween_property(color_rect, "color:a", 1, fade_length)
	return tween


func fade_in_slow() -> Tween: 
	var tween := create_tween()
	color_rect.color = Color(0,0,0,0)
	tween.tween_property(color_rect, "color:a", 1, fade_length*3)
	return tween


func fade_out() -> Tween: 
	var tween := create_tween()
	color_rect.color = Color(0,0,0,1)
	tween.tween_property(color_rect, "color:a", 0, fade_length)
	return tween


func fade_crash_in() -> Tween: 
	var tween := create_tween()
	color_rect.color = Color(1,1,1,0)
	tween.tween_property(color_rect, "color:a", 1, 0)
	return tween


func fade_crash_out() -> Tween: 
	var tween := create_tween()
	color_rect.color = Color(1,1,1,1)
	tween.tween_property(color_rect, "color:a", 0, fade_length * 2).set_delay(.5)
	return tween
