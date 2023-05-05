extends Area2D

@export var velocity = 400;
@export var direction : Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.rotate(Vector2(1,0).angle_to(direction));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * velocity * delta;
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free();
	pass # Replace with function body.



func _on_area_entered(area):
	if ("Dandelion" in area.name || "Turret" in area.name):
		area.takeDamage();
		queue_free();
	pass # Replace with function body.
