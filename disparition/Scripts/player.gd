class_name PlayerBody extends CharacterBody2D

const SPEED = 300.0
signal mort(body)


func _physics_process(delta: float) -> void:
	
	var direction_x = Input.get_axis("Gauche","Droite")
	var direction_y = Input.get_axis("Haut","Bas")
	
	var direction = Vector2(direction_x,direction_y).normalized()
	if direction:
		velocity=direction*SPEED
	else :
		velocity.x = move_toward(velocity.x,0,SPEED)
		velocity.y = move_toward(velocity.y,0,SPEED)


	move_and_slide()



func player_touched():
	mort.emit()
