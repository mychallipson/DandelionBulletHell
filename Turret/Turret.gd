extends Area2D

@export var delay = 3;
var health = 3;
var initialRot = 0;
var phase = 0;
var takingDamage = false;
var numShots = 6;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("fullGrow");
	$ShootTimer.start(delay);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (takingDamage):
		health = health - 1;
	updateHealth();
	pass

func distributed_rotations():
	var rotations = [];
	for i in range(0, numShots):
		var fraction = float(i) / float(numShots) + initialRot;
		var difference = 2*PI;
		rotations.append((fraction * difference));
	return rotations;

func _on_shoot_timer_timeout():
	initialRot = randf_range(0,PI/(numShots/2));
	var rotations = distributed_rotations();
	for i in range(0,distributed_rotations().size()):
		GameEngine.shootSeedBullet(position, rotations[i]);
	pass # Replace with function body.

func takeDamage():
	health = health - 1;
	pass;
	
func updateHealth():
	var healthBar = $HealthBar
	healthBar.value = health;
	
	if health >= 3:
		healthBar.visible = false;
	elif health <= 0:
		GameEngine.turretKillCount += 1;
		queue_free();
	else:
		healthBar.visible = true;


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("done_grow");


func _on_body_entered(body):
	if body.name == "Player":
		takingDamage = true;
	pass # Replace with function body.


func _on_body_exited(body):
	if body.name == "Player":
		takingDamage = false;
	pass # Replace with function body.
