extends Area2D

@export var velocity = 400;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(cos(rotation), -sin(rotation)) * velocity * delta;
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
	pass # Replace with function body.
