extends CharacterBody2D

@export var speed = 400;
@export var clampToWindowBorders = true;
var fireRate = 0.3;
var health = 10;
var maxHealth = 10;
var invulnTime = 0.4;
var canTakeDamage = true;
var healthyFace = preload("res://assets/faceHH.png");
var damagedFace = preload("res://assets/faceLH.png");
var almostDeadFace = preload("res://assets/faceNH.png");
var beesStomped = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.max_value = maxHealth;
	$Invulnerability.wait_time = invulnTime;
	$Invulnerability.one_shot = true;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity.x = int(Input.is_action_pressed("ui_d")) - int(Input.is_action_pressed("ui_a"));
	velocity.y = int(Input.is_action_pressed("ui_s")) - int(Input.is_action_pressed("ui_w"));
	velocity = velocity.normalized();
	velocity = velocity * speed;
	move_and_slide();
	GameEngine.playerPosition = position;
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
	if (canTakeDamage):
		health = health-1;
		canTakeDamage = false;
		$Invulnerability.start();
		$Damage.play();
	pass
	
func heal():
	if health < maxHealth:
		health = health+1;

func stompBee():
	beesStomped += 1;
	if beesStomped >= GameEngine.level && health < maxHealth:
		heal();
		beesStomped = 0;

func updateHealth():
	var healthBar = $HealthBar
	healthBar.value = health;
	
	if health >= maxHealth:
		healthBar.visible = false;
	elif health <= 0:
		GameEngine.gameOver();
	else:
		healthBar.visible = true;
	updatePlayerSprite();

func updatePlayerSprite():
	if health >= 7:
		$Sprite2D.texture = healthyFace;
	elif health > 2 && health < 7:
		$Sprite2D.texture = damagedFace;
	else:
		$Sprite2D.texture = almostDeadFace;
		

func _on_invulnerability_timeout():
	canTakeDamage = true;
	pass # Replace with function body.
