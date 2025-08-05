class_name PlayerBody extends CharacterBody2D

const SPEED = 300.0
signal mort(body)

const sort = preload("res://Scenes/ocuspocus.tscn")
var sort_possible = true

func _physics_process(delta: float) -> void:
	
	var direction_x = Input.get_axis("Gauche","Droite")
	var direction_y = Input.get_axis("Haut","Bas")
	
	var direction = Vector2(direction_x,direction_y).normalized()
	if direction:
		velocity=direction*SPEED
	else :
		velocity.x = move_toward(velocity.x,0,SPEED)
		velocity.y = move_toward(velocity.y,0,SPEED)

	if Input.is_action_just_pressed("lancer un sort") :
		lancer_sort()

	move_and_slide()



func player_touched():
	print("t mort lol")

func set_pos(new_pos : Vector2) -> void :
	position = new_pos


func lancer_sort() :
	if sort_possible :
		#sort_possible = false
		
		var sort_scene = sort.instantiate()
		
		
		var angle = position.angle_to_point(get_global_mouse_position())
		
		var nouveau_sort = sort.instantiate()
		
		var coord_x = 512*cos(angle)*abs(cos(angle))
		var coord_y = 512*sin(angle)*abs(sin(angle))
		print(coord_x," " ,coord_y)
		
		nouveau_sort.init(Vector2(coord_x,coord_y))
		
		nouveau_sort.position = position
		
		var c = cos(angle)
		var s = sin(angle)
		
		if abs(c) > abs(s) :
			nouveau_sort.position.x += 32 * abs(c)/c
		else :
			nouveau_sort.position.y += 32 * abs(s)/s
		
		get_parent().add_child(nouveau_sort)
		print()
