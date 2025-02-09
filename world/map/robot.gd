extends StaticBody2D
class_name Robot


@onready var shadow: Sprite2D = $Shadow
@onready var broken_shadow: Sprite2D = $Sprite2D/Shadow
@onready var broken_shadow_2: Sprite2D = $Sprite2D/Shadow2
@onready var broken_shadow_3: Sprite2D = $Sprite2D/Shadow3
@onready var sprite_2d: Sprite2D = $Sprite2D


func set_broke() -> void: 
	sprite_2d.frame = 1
	shadow.hide()
	broken_shadow.show()
	broken_shadow_2.show()
	broken_shadow_3.show()


func set_fix() -> void: 
	sprite_2d.frame = 0
	shadow.show()
	broken_shadow.hide()
	broken_shadow_2.hide()
	broken_shadow_3.hide()
