extends Area2D

const MOVELEFT = "Left"
const MOVERIGHT = "Right"
const NOTMOVING = "None"

var valid_positions = [220.0,412.0,668.0,860.0]
var target_position
var run_direction = -1
var move_direction = "None"
var speed = 300

signal game_state(state) 

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		move_direction = MOVELEFT

	if Input.is_action_just_pressed("ui_right"):
		move_direction = MOVERIGHT

func _physics_process(delta):
	side_movement_processing()
	move_direction = NOTMOVING
	vertical_movement(delta)

func side_movement_processing() -> void:
	
	if move_direction == NOTMOVING:
		return
	
	if move_direction == MOVERIGHT:
		if position.x != valid_positions[valid_positions.size() - 1]:
			var position_index = valid_positions.find(position.x)
			if position_index == -1:
				return
			position.x = valid_positions[position_index + 1]
			return
	
	if move_direction == MOVELEFT:
		if position.x != valid_positions[0]:
			var position_index = valid_positions.find(position.x)
			if position_index == -1:
				return
			position.x = valid_positions[position_index - 1]
			return

func vertical_movement(delta) -> void:
	
	position.y += run_direction * speed * delta

func die() -> void:
	$AnimationPlayer.play("Death")
	set_physics_process(false)
	emit_signal("game_state", "lose")


func win() -> void:
	set_physics_process(false)
	$AnimationPlayer.stop(true)
	emit_signal("game_state", "win")


func _on_Player_area_entered(area):
	if area.is_in_group("Things that kill"):
		die()
	
	if area.is_in_group("Prize"):
		run_direction = 1
		$Front.hide()
		$Back.show()
		area.queue_free()
	
	if area.is_in_group("Exit") && run_direction == 1:
		win()
