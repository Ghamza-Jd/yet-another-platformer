extends CharacterBody2D

var m_gravity = 300.0
var m_velocity = Vector2.ZERO
var m_max_horizontal_speed = 100
var m_jump_speed = 200.0

func _ready():
	pass

func _process(delta):
	var move_vec = Vector2.ZERO
	move_vec.x = Input.get_action_strength("move_right") \
		- Input.get_action_strength("move_left")
	move_vec.y = -1 if Input.is_action_just_pressed("jump") else 0
	
	m_velocity.x = move_vec.x * m_max_horizontal_speed
	m_velocity.y += m_gravity * delta
	if (move_vec.y < 0 and is_on_floor()):
		m_velocity.y = move_vec.y * m_jump_speed
	
	velocity = m_velocity
	var has_collided = move_and_slide()
	if (has_collided):
		m_velocity = Vector2.ZERO
