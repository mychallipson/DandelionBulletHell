extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


func _on_1_to_2_pressed():
	$TutPage2.visible = true;
	pass # Replace with function body.


func _on_2_to_3_pressed():
	$TutPage3.visible = true;
	pass # Replace with function body.


func _on_2_to_1_pressed():
	$TutPage2.visible = false;
	pass # Replace with function body.


func _on_3_to_2_pressed():
	$TutPage3.visible = false;
	pass # Replace with function body.


func _on_to_title_pressed():
	GameEngine.toTitle();
	pass # Replace with function body.
