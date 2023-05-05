extends Area2D

@export var numSeeds = 5;
@export var min_rotation = PI/4;
@export var max_rotation = 3*PI/4 ;
@export var health = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	var delay = randf_range(0,1.5);
	$AnimatedSprite2D.play("fullGrow");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateHealth();
	pass
	
func random_rotations():
	var rotations = [];
	for _i in range(0, numSeeds):
		rotations.append(randf_range(min_rotation, max_rotation));
	return rotations;

func shootSeed():
	var rotations = random_rotations();
	var flowerIndex = randi_range(0,numSeeds-1);
	for i in range(0, numSeeds):
		GameEngine.spawnSeed(position, rotations[i], i == flowerIndex);

func _on_spread_delay_timeout():
	shootSeed();
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("done_grow");
	shootSeed();
	$SpreadDelay.start(3);
	pass # Replace with function body.
	
func takeDamage():
	health = health - 1;
	if health <= 0:
		queue_free();
		GameEngine.dandelionKillCount += 1;

func updateHealth():
	var healthBar = $HealthBar
	healthBar.value = health;

	if health >= 10:
		healthBar.visible = false;
	elif health <= 0:
		queue_free();
	else:
		healthBar.visible = true;

