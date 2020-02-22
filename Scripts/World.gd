extends Node2D

onready var Camera = $Camera

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("Left"):
		$Camera.add_trauma(5)
	if Input.is_action_pressed("Right"):
		$Camera.add_trauma(1)
	if Input.is_action_pressed("Down"):
		$Camera.add_trauma(4)
	if Input.is_action_pressed("Up"):
		$Camera.add_trauma(90)
