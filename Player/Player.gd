extends CharacterBody2D

@export var speed = 200;
@export var clampToWindowBorders = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"));
	velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"));
	velocity = velocity.normalized();
	velocity = velocity * speed;
	move_and_slide();
	
	if clampToWindowBorders:
		global_position = Vector2(clamp(global_position.x, 0, GameEngine.screenBorders.x), clamp(global_position.y, 0, GameEngine.screenBorders.y));
	
	
