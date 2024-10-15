extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Stadium.goal_scored.connect(_on_stadium_goal_scored)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_stadium_goal_scored(team):
	match team:
		"1":
			$UI/Score1.text = str(int($UI/Score1.text) + 1)
		"2":
			$UI/Score2.text = str(int($UI/Score2.text) + 1)
