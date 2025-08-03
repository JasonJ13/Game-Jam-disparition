class_name Ennemi extends CharacterBody2D

@onready var sight: Area2D = $Sight
@onready var rectangle: Sprite2D = $Sight/Rectangle
@onready var attaque: Area2D = $Attaque

@export var EstEnnemiFixe :bool 
@export var DirectionInit:int

enum State{LOOK, WALK, AGGRO}

const DIRECTIONS = [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]
var index:int

var currentState : State
var player:CharacterBody2D
var playerDetected:bool
var playerInSight:bool

var direction:Vector2

const SPEED = 300.0
const AGGRO_SPEED = 350.0

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
			if is_blocked(delta):
				#change_state(State.LOOK)
				turn_right()
			velocity=SPEED*direction
		State.AGGRO:
			direction=(player.global_position-global_position).normalized()
			velocity=AGGRO_SPEED*direction
			if !playerInSight:
				if EstEnnemiFixe:
					change_state(State.LOOK)
				else :
					change_state(State.WALK)
	
	look_at_direction(direction)
	move_and_slide()



func is_blocked(delta):
	var collide = move_and_collide(direction*delta,true,0.01)
	if collide :
		return true
	else :
		return false




func change_state(state):
	currentState=state


func _on_sight_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		player=body
		playerDetected=true


func _on_sight_body_exited(body: Node2D) -> void:
	playerDetected=false
	playerInSight=false
	change_state(State.LOOK)

func sight_check():
	var space_state = get_world_2d().direct_space_state
	var sightParameters = PhysicsRayQueryParameters2D.create(global_position,player.global_position,collision_mask,[self])
	var sight_check = space_state.intersect_ray(sightParameters)
	if len(sight_check)>0 and sight_check["collider"] is PlayerBody:
		playerInSight=true
		change_state(State.AGGRO)
	else:
		playerInSight=false

func turn_right():
	index = (index+1)%4
	direction=DIRECTIONS[index]

func look_at_direction(dir):
	sight.look_at(position+dir)
	rectangle.look_at(position+dir)


func _on_attaque_body_entered(body: Node2D) -> void:
	for col in attaque.get_overlapping_bodies():
		if col is PlayerBody:
			print(col)
			col.player_touched()
