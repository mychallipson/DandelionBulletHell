extends Area2D

@export var numSeeds = 5;
@export var min_rotation = PI/4;
@export var max_rotation = 3*PI/4 ;
@export var health = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	var delay = randf_range(0,2);
	$SpreadDelay.one_shot = true;
	$SpreadDelay.start(delay);
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

func distributed_rotations():
	var rotations = [];
	for i in range(0, numSeeds):
		var fraction = float(i) / float(numSeeds);
		var difference = max_rotation - min_rotation;
		rotations.append((fraction * difference) + min_rotation);
	return rotations;


func _on_spread_delay_timeout():
	$AnimatedSprite2D.play("idle");
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	var rotations = random_rotations();
	for i in range(0, numSeeds):
		var newFlower = randi_range(0,10) < 1;
		GameEngine.spawnSeed(position, rotations[i], newFlower);
	var delay = randf_range(0,2);
	$AnimatedSprite2D.pause();
	$SpreadDelay.start(delay);
	pass # Replace with function body.
	
func takeDamage():
	health = health - 1;
	if health <= 0:
		queue_free();
		GameEngine.dandelionKill();

func updateHealth():
	var healthBar = $HealthBar
	healthBar.value = health;
	
	if health >= 10:
		healthBar.visible = false;
	elif health <= 0:
		queue_free();
	else:
		healthBar.visible = true;
