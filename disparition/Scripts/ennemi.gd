class_name Ennemi extends CharacterBody2D


@onready var sight: Area2D = $"../Sight"
@onready var rectangle: Sprite2D = $"../Rectangle"


const SPEED = 300.0

func move(direction):
	velocity=direction*SPEED
	RotateArea(direction)
	move_and_slide()

func is_blocked(direction):
	return move_and_collide(direction*SPEED,true)

func RotateArea(direction):
	sight.look_at(global_position+direction)
	rectangle.look_at(global_position+direction)
	
func look_around(direction:Vector2):
	var look=direction
	for i in range(3):
		look = look.rotated(deg_to_rad(90))
		print(look)
		RotateArea(look)
		await get_tree().create_timer(1).timeout
	RotateArea(direction)
