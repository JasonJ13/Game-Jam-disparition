class_name PlayerBody extends CharacterBody2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var occus_1: AudioStreamPlayer2D = $occus/occus1
@onready var occus_2: AudioStreamPlayer2D = $occus/occus2
@onready var occus_3: AudioStreamPlayer2D = $occus/occus3
@onready var mort: AudioStreamPlayer2D = $mort

var son : int

const SPEED = 300.0
var deltaw : float

var must_wait=false

const sort = preload("res://Scenes/ocuspocus.tscn")
var sort_possible = true
var est_visible=false
var moving=false
var walk_fx=false

var torche_count:int

func _physics_process(delta: float) -> void:
	
	var direction_x = Input.get_axis("Gauche","Droite")
	var direction_y = Input.get_axis("Haut","Bas")
	
	
	
	var direction = Vector2(direction_x,direction_y).normalized()
	if direction:
		moving=true
		velocity=direction*SPEED
	else :
		moving=false
		velocity.x = move_toward(velocity.x,0,SPEED)
		velocity.y = move_toward(velocity.y,0,SPEED)

	if Input.is_action_just_pressed("lancer un sort") && !must_wait:
		lancer_sort()
		son = randi_range(1,3)
		if son==1:
			occus_1.play()
		elif son==2:
			occus_2.play()
		elif son==3:
			occus_3.play()
	
	if must_wait:
		velocity=Vector2.ZERO
	move_and_slide()
	
		
	
	deltaw =delta

func _process(delta: float) -> void:
	if moving and !walk_fx:
		audio_stream_player_2d.play()
		walk_fx=true
		await get_tree().create_timer(1).timeout
		walk_fx=false
	if !moving :
		walk_fx=false
		audio_stream_player_2d.stop()
	
	



func player_touched():
	
	if son==1:
		occus_1.stop()
	elif son==2:
		occus_2.stop()
	elif son==3:
		occus_3.stop()
	
	mort.play()
	must_wait=true
	await mort.finished
	get_tree().reload_current_scene()
	

func set_pos(new_pos : Vector2) -> void :
	position = new_pos


func lancer_sort() :
	if sort_possible :
		sort_possible = false

		var angle = position.angle_to_point(get_global_mouse_position())
		var nouveau_sort = sort.instantiate()
		
		
		
		var c = cos(angle)
		var s = sin(angle)
		
		nouveau_sort.position = position
		if abs(c) > abs(s) :
			nouveau_sort.position.x += 32 * abs(c)/c
		else :
			nouveau_sort.position.y += 32 * abs(s)/s

		angle = nouveau_sort.position.angle_to_point(get_global_mouse_position())
		
		c = cos(angle)
		s = sin(angle)
		
		var coord_x = 10*c/deltaw
		var coord_y = 10*s/deltaw
	
		nouveau_sort.init(Vector2(coord_x,coord_y),angle)
		
		get_parent().add_child(nouveau_sort)

func change_visibilte(visible:bool):
	est_visible=visible
