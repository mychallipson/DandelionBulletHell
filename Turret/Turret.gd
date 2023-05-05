extends Area2D

@export var delay = 3;
var health = 3;
var initialRot = 0;
var phase = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("fullGrow");
	initialRot = randf_range(0,PI/4);
	$ShootTimer.start(delay);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updateHealth()
	pass

func distributed_rotations():
	var rotations = [];
	for i in range(0, 8):
		var fraction = float(i) / float(8) + initialRot;
		var difference = 2*PI;
		rotations.append((fraction * difference));
	return rotations;

func _on_shoot_timer_timeout():
	initialRot = randf_range(0,PI/4);
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
		GameEngine.turretKill();
		queue_free();
	else:
		healthBar.visible = true;


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("done_grow");
#
#
#func _on_grow_timer_timeout():
#	match (phase):
#		0:
#			$AnimatedSprite2D.play("first_shot");
#			phase = 1;
#			return;
#		1:
#			$AnimatedSprite2D.play("second_shot");
#			phase = 2;
#			return
#		2:
#			$AnimatedSprite2D.play("third_shot");
#			phase = 3;
#			return
#		3:
#			$AnimatedSprite2D.play("max_growth");
#			phase = 4;
#			return
#	pass # Replace with function body.
