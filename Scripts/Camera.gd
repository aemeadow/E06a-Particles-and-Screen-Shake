extends Camera2D

export var decay = 0.8
export var decay_rate = 0.4
export var max_offset = 20
export var max_roll = 0.1 
export (NodePath) var target  

var trauma = 0.0  
var trauma_power = 2
 
var _start_position
var _start_rotation
var _trauma
 
func _ready():
	_start_position = position
	_trauma = 0.0

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
 
func shake():
	var amount = pow(trauma, trauma_power)

func _process(delta):
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	   
func _decay_trauma(delta):
	var change = decay_rate * delta
	_trauma = max(_trauma - change, 0)
 
func _apply_shake():
	var shake = _trauma * _trauma
	var o_x = max_offset * shake * _get_neg_or_pos_scalar()
	var o_y = max_offset * shake * _get_neg_or_pos_scalar()
	position = _start_position + Vector2(o_x, o_y)
	if Input.is_action_pressed("Left"):
		add_trauma(0.5)
	if Input.is_action_pressed("Right"):
		add_trauma(0.5)
	if Input.is_action_pressed("Down"):
		add_trauma(0.5)
	if Input.is_action_pressed("Up"):
		add_trauma(0.5)

func _get_neg_or_pos_scalar():
	return rand_range(-1.0, 1.0)
