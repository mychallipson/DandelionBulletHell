extends Node2D

var isPaused = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	Node.PROCESS_MODE_ALWAYS;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Level/LevelText.text = str(GameEngine.level);
	pass

func _input(event):
	if event.is_action_pressed("ui_esc"):
		if isPaused && $Pause.visible:
			$Pause.hide();
			get_tree().paused = false;
			isPaused = false;
		else:
			$Pause.loadValues();
			$Pause.show();
			get_tree().paused = true;
			isPaused = true;
		
	
	
