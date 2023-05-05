extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimeLabel/Time.text = str(snapped(GameEngine.elapsedTime,0.01));
	$MonstersLabel/MonstersKilled.text = str(GameEngine.dandelionKillCount);
	$DandelionLabel/DandelionsKilled.text = str(GameEngine.turretKillCount);
	$SeedsLabel/SeedsCaught.text = str(GameEngine.seedsCaught);
	pass # Replace with function body.
