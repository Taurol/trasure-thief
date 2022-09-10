extends Area2D

var valid_positions = [180,540,900]
var target_position
var run_direction = "Up"
var move_direction = "None"
var speed = 500

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		move_direction = "Left"

	if Input.is_action_just_pressed("ui_right"):
		move_direction = "Right"




func _physics_process(delta):
	
	side_movement_calculations()
	move_player(delta)
	

func side_movement_calculations() -> void:
	print(valid_positions[0])
	if move_direction == "None":
		return
	
	if move_direction == "Left" && valid_positions[0] * 0.9 < position.x && position.x < valid_positions[0] * 1.1:
		move_direction = "None"
		return
	
	if move_direction == "Right" && valid_positions[2] * 0.9 < position.x && position.x < valid_positions[2] * 1.1:
		move_direction = "None"
		return
	
	if move_direction == "Left":
		if position.x < valid_positions[0] * 1.1 || (valid_positions[1] * 0.9 < position.x && position.x < valid_positions[1] * 1.1):
			move_direction = "None" 
			return
	
	if move_direction == "Right":
		if position.x > valid_positions[2] * 0.9 || (valid_positions[1] * 0.9 > position.x && position.x > valid_positions[1] * 1.1):
			move_direction = "None" 
			return

func move_player(delta) -> void:
	var move_vector: Vector2 = Vector2.ZERO
	
	if move_direction == "Left":
		move_vector.x -= speed * delta
	if move_direction == "Right":
		move_vector.x += speed * delta
	
	position += move_vector


