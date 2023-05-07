extends Node2D

@onready var MainGameScene = preload("res://MainScene.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		get_tree().change_scene_to_packed(MainGameScene);
		GameEngine.startGame();
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(MainGameScene);
	GameEngine.startGame();
	pass # Replace with function body.
