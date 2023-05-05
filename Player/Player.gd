extends CharacterBody2D

@export var speed = 200;
@export var clampToWindowBorders = true;
var fireRate = 0.2;
var health = 10;
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity.x = int(Input.is_action_pressed("ui_d")) - int(Input.is_action_pressed("ui_a"));
	velocity.y = int(Input.is_action_pressed("ui_s")) - int(Input.is_action_pressed("ui_w"));
	velocity = velocity.normalized();
	velocity = velocity * speed;
	move_and_slide();
	updateHealth();
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && $GunCD.is_stopped():
		shoot()
		
	
	if clampToWindowBorders:
		global_position = Vector2(clamp(global_position.x, 0, GameEngine.screenBorders.x), clamp(global_position.y, 0, GameEngine.screenBorders.y));
	
	
func shoot():
	var vec = get_global_mouse_position() - position;
	GameEngine.shootBullet(vec.normalized(), position);
	$GunCD.one_shot = true;
	$GunCD.start(fireRate);

func take_damage():
	health = health-1;
	pass
	

func updateHealth():
	var healthBar = $HealthBar
	healthBar.value = health;
	
	if health >= 100:
		healthBar.visible = false;
	elif health <= 0:
		GameEngine.gameOver();
	else:
		healthBar.visible = true;
