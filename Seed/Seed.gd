extends Area2D

@export var shotSpeed = 300;
@export var fallSpeed = 100;
@export var falltime = 2;
@export var amplitude = 2;
@export var frequency = 0.5;
@export var speed = shotSpeed;
@export var newFlower = false;
var time = 0;
var launch = true;
var launchTime = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	if newFlower:
		modulate = "ffff38";
	$Launch.one_shot = true;
	$Launch.start(launchTime);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launch:
		position += Vector2(cos(rotation), -sin(rotation)) * speed * delta;
	else:
		time += delta;
		rotation = 0;
		position += transform.x * -amplitude * sin(2*PI*frequency*time + PI / 2) * speed * delta;
		position += transform.y * speed * delta;
		if position.y > GameEngine.screenBorders.y:
			queue_free()
		


func _on_launch_timeout():
	launch = false;
	speed = fallSpeed;
	if newFlower:	
		$Fall.one_shot = true;
		$Fall.start(falltime);


func _on_fall_timeout():
	if $ScreenVisibility.is_on_screen():
		GameEngine.spawnTurret(position);
		queue_free();


func _on_body_entered(body):
	if (body.name == "Player"):
		body.take_damage();