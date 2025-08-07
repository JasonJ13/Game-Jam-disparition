class_name Ennemi extends CharacterBody2D

@onready var sight: Area2D = $Sight
@onready var rectangle: Sprite2D = $Sight/Rectangle
@onready var attaque: Area2D = $Attaque
@onready var aggro: AudioStreamPlayer2D = $aggro

@export var EstEnnemiFixe :bool 
@export var DirectionInit:int
@export var Only180Turn:bool

var est_disparue : bool = false

enum State{LOOK, WALK, AGGRO}

const DIRECTIONS = [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]
var index:int

var currentState : State
var player:PlayerBody
var playerDetected:bool
var playerInSight:bool

var direction:Vector2
var first_aggro = true

const SPEED = 300.0
const AGGRO_SPEED = 400.0

func _ready() -> void:
	index=DirectionInit
	direction=DIRECTIONS[index]
	look_at_direction(direction)
	if EstEnnemiFixe:
		change_state(State.LOOK)
	else : 
		change_state(State.WALK)

func _process(delta: float) -> void:
	if playerDetected:
		sight_check()
	match currentState:
		State.LOOK:
			velocity=Vector2.ZERO
		State.WALK:
			if is_blocked():
				if Only180Turn:
					turn_180()
				else:
					turn_right()
			velocity=SPEED*direction
		State.AGGRO:
			if first_aggro:
				first_aggro=false
				aggro.play()
			direction=(player.global_position-global_position).normalized()
			velocity=AGGRO_SPEED*direction
			if !playerInSight:
				if EstEnnemiFixe:
					change_state(State.LOOK)
					first_aggro = true
				else :
					change_state(State.WALK)
					first_aggro = true
	
	look_at_direction(direction)
	move_and_slide()



func is_blocked():
	if test_move(global_transform,direction*10):
		return true
	return false



func change_state(state):
	currentState=state


func _on_sight_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		player=body
		playerDetected=true


func _on_sight_body_exited(body: Node2D) -> void:
	if body is PlayerBody :
		playerDetected=false
		playerInSight=false
		if EstEnnemiFixe :
			change_state(State.LOOK)
		else :
			change_state(State.WALK)

func sight_check():
	var space_state = get_world_2d().direct_space_state
	var sightParameters = PhysicsRayQueryParameters2D.create(global_position,player.global_position,collision_mask,[self])
	var sight_check = space_state.intersect_ray(sightParameters)
	
	if len(sight_check)>0 and sight_check["collider"] is PlayerBody and player.est_visible and !est_disparue:
		playerInSight=true
		change_state(State.AGGRO)
	else:
		playerInSight=false

func turn_right():
	index = (index+1)%4
	direction=DIRECTIONS[index]

func turn_180():
	index = (index+2)%4
	direction=DIRECTIONS[index]

func look_at_direction(dir):
	sight.look_at(position+dir)
	rectangle.look_at(position+dir)


func _on_attaque_body_entered(body: Node2D) -> void:
	for col in attaque.get_overlapping_bodies():
		if col is PlayerBody && not(est_disparue):
			col.player_touched()
			


func disparue() -> void :
	est_disparue = true
	set_process_mode(Node.PROCESS_MODE_DISABLED)
	hide()
	

func apparue() -> void :
	set_process_mode(Node.PROCESS_MODE_INHERIT)
	show()
	est_disparue = false
