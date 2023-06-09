extends Node2D

@export var restart = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED;
	loadValues();
	pass # Replace with function body.

func loadValues():
	$TimeLabel/Time.text = str(snapped(GameEngine.elapsedTime,0.01));
	$MonstersLabel/MonstersKilled.text = str(GameEngine.dandelionKillCount);
	$DandelionLabel/DandelionsKilled.text = str(GameEngine.turretKillCount);
	$SeedsLabel/SeedsCaught.text = str(GameEngine.seedsCaught);

func _input(event):
	if event.is_action_pressed("ui_esc"):
		get_tree().paused = false;


func _on_button_pressed():
	GameEngine.clearScene();
	GameEngine.startGame();
	hide();
	get_tree().paused = false;
	pass # Replace with function body.
