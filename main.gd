extends Node

@onready var start_room = $startRoom

# Called when the node enters the scene tree for the first time.
func _ready():
	start_room.exit_entered.connect(_exit_room1)
	$Goblin.player = $player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _exit_room1(_body, dir):
	match dir:
		"north":
			pass
		"east":
			$room2/Camera3D.make_current()
		"south":
			$room3/Camera3D.make_current()
		"west":
			pass
		_: # This is default in godot
			pass
