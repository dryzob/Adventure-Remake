extends CharacterBody3D

@export var ATTACK_SPEED: float = 5.0
@export var IDLE_SPEED: float = 2.0
@export var IDLE_RANGE: float = 3.0

@onready var detector = $DetectionRange
@onready var aggro = $AggroRange

enum {
	IDLE,
	ATTACK
}

var state = IDLE
var rng = RandomNumberGenerator.new()
var delay: float = 2.0
var idling = true
var move_target
var player

func _ready():
	move_target = idle()
	detector.body_entered.connect(_detected_player)
	aggro.body_exited.connect(_lost_player)

func _physics_process(delta):
	match state:
		IDLE:
			if $idleTimer.is_stopped():
				if idling:
					idling = false
					$idleTimer.start()
					move_target = idle()
				
				if global_position.snapped(Vector3(0.1,0.1,0.1)) != move_target.snapped(Vector3(0.1,0.1,0.1)):
					move(move_target, delta, true)
				else:
					idling = true
			else:
				await $idleTimer.timeout
		ATTACK:
			move(player.global_position, delta, false)

# BUG FIX : WILL RUN INTO WALLS AND STUNT THE CODE (RAYS?)
func move(target, delta, idle_move:bool):
	var direction = (transform.basis * (target - global_position)).normalized()
	if !idle_move:
		# Gonna add some random to the movement
		var steering = ((direction * ATTACK_SPEED) - velocity) * delta * 2.5
		velocity += steering
	else:
		velocity = (direction * IDLE_SPEED)
	move_and_slide()

func idle():
	rng.randomize()
	var randomNum = rng.randf()
	var center = global_position
	var angle = randomNum * 2 * PI
	var y = global_position.y
	var x = center.x + cos(angle) * IDLE_RANGE
	var z = center.z + sin(angle) * IDLE_RANGE
	
	return Vector3(x, y, z)

func _detected_player(body):
	if body == player:
		state = ATTACK

func _lost_player(body):
	if body == player && state == ATTACK:
		state = IDLE
		move_target = idle()
