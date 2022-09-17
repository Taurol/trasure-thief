extends Camera2D

onready var player = owner.get_node("Player")

func _ready():
	pass

func _process(delta):
	position.y = player.position.y
