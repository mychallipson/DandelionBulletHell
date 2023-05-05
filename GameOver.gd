extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimeLabel/Time.text = str(GameEngine.elapsedTime);
	$MonsterLabel/MonstersKilled.text = str(GameEngine.dandelionKillCount);
	$DandelionLabel/DandelionsKilled.text = str(GameEngine.turretKillCount);
	pass # Replace with function body.
