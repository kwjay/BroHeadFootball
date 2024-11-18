extends Node2D

@onready var path_follows : Array = [$LeftHeads/Path2D/PathFollow2D, $RightHeads/Path2D/PathFollow2D]
@export var speed = 10

func _process(delta):
	for path in path_follows:
		path.progress += speed * delta
