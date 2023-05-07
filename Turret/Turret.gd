extends Area2D

@export var delay = 2;
var initialRot;
var phase = 0;
var numShots = 6;
var initialDelay = 2;

# Called when the node enters the scene tree for the first time.
func _ready():
	$BeeAnim.one_shot = true;
	$BeeAnim.start(initialDelay);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#
#func distributed_rotations():
#	var rotations = [];
#	for i in range(0, numShots):
#		var fraction = float(i) / float(numShots) + initialRot;
#		var difference = 2*PI;
#		rotations.append((fraction * difference));
#	return rotations;

func _on_shoot_timer_timeout():
	$Stinger.play();
	GameEngine.shootSeedBullet(position, initialRot + randf_range(-PI / 8, PI / 8));
#	initialRot = randf_range(0,PI/(numShots/2));
#	var rotations = distributed_rotations();
#	for i in range(0,distributed_rotations().size()):
#		GameEngine.shootSeedBullet(position, rotations[i]);
	
	pass # Replace with function body.



func _on_body_entered(body):
	if body.name == "Player":
		body.stompBee();
		GameEngine.turretKillCount += 1;
		queue_free();
	pass # Replace with function body.



func _on_bee_anim_timeout():
	var vec = GameEngine.vectorToPlayer(position);
	initialRot = Vector2(1,0).angle_to(vec) - PI/4;
	$Turret/Bee.rotate(initialRot);
	$Turret/Hive.visible = false;
	$Turret/Bee.visible = true;
	$Turret/Bee.play("flapping");
	$ShootTimer.start(delay);
	pass # Replace with function body.

