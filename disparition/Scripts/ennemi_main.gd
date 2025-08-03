class_name Ennemi_Main extends Node2D

@export var EstEnnemiFixe :bool = false
@export var DirectionInit:int = 0

enum State{LOOK, WALK, AGGRO}

const DIRECTIONS = [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]


var currentState = State.LOOK
var player:CharacterBody2D
var playerDetected:bool
var playerInSight:bool

var direction:Vector2

func _ready() -> void:
	direction=Vector2.RIGHT


func _process(delta: float) -> void:
	print(position)
	print(ennemi.position)
	match currentState:
		State.LOOK :
			ennemi.velocity=Vector2.ZERO
			if playerDetected:
				sight_check()
				if playerInSight:
					currentState=change_state(State.AGGRO)
		
			
		
	if playerDetected:
		sight_check()
	ennemi.move(direction)
	#ennemi.turn_right(direction)
	
func change_state(state):
	currentState=state


func _on_sight_body_entered(body: Node2D) -> void:
	if body is PlayerBody:
		player=body
		print("Player détecté")
		playerDetected=true


func _on_sight_body_exited(body: Node2D) -> void:
	print("player sorti")
	playerDetected=false
	playerInSight=false

func sight_check():
	var space_state = get_world_2d().direct_space_state
	var sightParameters = PhysicsRayQueryParameters2D.create(global_position,player.global_position,ennemi.collision_mask,[self])
	var sight_check = space_state.intersect_ray(sightParameters)
	if sight_check["collider"] is PlayerBody:
		playerInSight=true
		print("ahah")
	else:
		playerInSight=false
	
