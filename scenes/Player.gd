extends CharacterBody2D

var m_gravity: float = 1_000
var m_velocity: Vector2 = Vector2.ZERO
var m_max_horizontal_speed: float = 140
var m_jump_speed: float = 360
var m_horizontal_acceleration: float = 2_000
var m_jump_termination_multiplier: float = 4

func _ready():
	pass

func _process(delta: float):
	var move_vec = Vector2.ZERO
	move_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vec.y = -1 if Input.is_action_just_pressed("jump") else 0
	
	m_velocity.x += move_vec.x * m_horizontal_acceleration * delta
	if (move_vec.x == 0):
		m_velocity.x = lerp(0.0, m_velocity.x, pow(2, -50 * delta))
	m_velocity.x = clamp(m_velocity.x, -m_max_horizontal_speed, m_max_horizontal_speed)

	if (move_vec.y < 0 and is_on_floor()):
		m_velocity.y = move_vec.y * m_jump_speed
		
	if (m_velocity.y < 0 and not Input.is_action_pressed("jump")):
		m_velocity.y += m_gravity * m_jump_termination_multiplier * delta
	else:
		m_velocity.y += m_gravity * delta
	velocity = m_velocity
	move_and_slide()
