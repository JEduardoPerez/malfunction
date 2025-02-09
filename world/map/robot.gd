extends StaticBody2D
class_name Robot


@onready var shadow: Sprite2D = $Shadow
@onready var broken_shadow: Sprite2D = $Sprite2D/Shadow
@onready var broken_shadow_2: Sprite2D = $Sprite2D/Shadow2
@onready var broken_shadow_3: Sprite2D = $Sprite2D/Shadow3
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var repair_area: Area2D = $RepairArea
@onready var exclamation: Sprite2D = $Exclamation
@onready var robot_up: ExtendedAudioStreamPlayer = $SFXs/RobotUp
@onready var robot_up_2: ExtendedAudioStreamPlayer = $SFXs/RobotUp2


var player : Player
var is_mouse_on_robot : bool
var is_on_repair_mode : bool : set = set_is_on_repair_mode

func _ready() -> void:
	repair_area.body_entered.connect(_on_piece_body_entered)
	repair_area.body_exited.connect(_on_piece_body_exited)
	repair_area.mouse_entered.connect(_on_piece_mouse_entered)
	repair_area.mouse_exited.connect(_on_piece_mouse_exited)
	is_on_repair_mode = false


func _input(event: InputEvent) -> void:
	if not is_on_repair_mode: return
	if event.is_action_pressed("click") and player != null and is_mouse_on_robot: 
		repair()


func repair() -> void: 
	player.is_fixing = true
	is_on_repair_mode = false


func _on_piece_body_entered(body : Node2D) -> void: 
	if body is Player: player = body


func _on_piece_body_exited(body : Node2D) -> void: 
	if body is Player: player = null


func _on_piece_mouse_entered() -> void: 
	is_mouse_on_robot = true


func _on_piece_mouse_exited() -> void: 
	is_mouse_on_robot = false


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
	robot_up.play_at_random_pitch()
	await robot_up.finished
	robot_up_2.play_at_random_pitch()


func set_is_on_repair_mode(new_value : bool) -> void: 
	is_on_repair_mode = new_value
	exclamation.visible = is_on_repair_mode
