extends Node2D

@export var numSeeds = 5;
@export var min_rotation = PI/4;
@export var max_rotation = 3*PI/4 ;

# Called when the node enters the scene tree for the first time.
func _ready():
	var delay = randf_range(0,2);
	$SpreadDelay.one_shot = true;
	$SpreadDelay.start(delay);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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

	

func _on_animation_player_animation_finished(anim_name):
	var rotations = random_rotations();
	for i in range(0, numSeeds):
		var newFlower = randi_range(0,10) < 1;
		GameEngine.spawnSeed(position, rotations[i], newFlower);
	var delay = randf_range(0,2);
	$SpreadDelay.start(delay);
	pass # Replace with function body.


func _on_spread_delay_timeout():
	$AnimationPlayer.play("Grow");
	pass # Replace with function body.
