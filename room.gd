extends Node3D

@onready var northExit = $Exits/North
@onready var southExit = $Exits/South
@onready var eastExit = $Exits/East
@onready var westExit = $Exits/West

signal exit_entered(body, dir)
# Called when the node enters the scene tree for the first time.
func _ready():
	northExit.body_entered.connect(_exit_north)
	eastExit.body_entered.connect(_exit_east)
	southExit.body_entered.connect(_exit_south)
	westExit.body_entered.connect(_exit_west)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Mainly debugging
	if northExit.has_overlapping_bodies():
		print("North Exit")
	if southExit.has_overlapping_bodies():
		print("South Exit")
	if eastExit.has_overlapping_bodies():
		print("East Exit")
	if westExit.has_overlapping_bodies():
		print("West Exit")

func _exit_north(body):
	exit_entered.emit(body, "north")
func _exit_east(body):
	exit_entered.emit(body, "east")
func _exit_south(body):
	exit_entered.emit(body, "south")
func _exit_west(body):
	exit_entered.emit(body, "west")
