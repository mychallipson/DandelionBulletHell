extends Node2D

@onready var TitleScreenScene = preload("res://TitleScreen/TitleScreen.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	$TimeLabel/Time.text = str(snapped(GameEngine.elapsedTime,0.01));
	$MonstersLabel/MonstersKilled.text = str(GameEngine.dandelionKillCount);
	$DandelionLabel/DandelionsKilled.text = str(GameEngine.turretKillCount);
	$SeedsLabel/SeedsCaught.text = str(GameEngine.seedsCaught);
	$LevelLabel/Level.text = str(GameEngine.level);
	get_tree().paused = false;
	pass # Replace with function body.


func _on_button_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_packed(TitleScreenScene);
	pass # Replace with function body.
