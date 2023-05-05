extends Node2D

@onready var seedScene = preload("res://Seed/Seed.tscn");
@onready var dandelionScene = preload("res://Dandelion/Dandelion.tscn");
@onready var bulletScene = preload("res://Bullets/PlayerBullet.tscn");
@onready var seedBulletScene = preload("res://Bullets/SeedBullet.tscn");
@onready var turretScene = preload("res://Turret/Turret.tscn");
@onready var gameOverScene = preload("res://GameOver/GameOver.tscn");
@onready var screenBorders = get_viewport().get_visible_rect().size;

@export var spawnCount = 2;
var isGameOver = false;
var dandelionDelay = 10;
var spawnTimer = 0;
var elapsedTime = 0;
var dandelionKillCount = 0;
var turretKillCount = 0;
var spawnSeparation = 8;
var seedsCaught = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func startGame():
	for i in range(0, spawnCount):
		var pos = Vector2(randi_range(0, screenBorders.x),randi_range(0, screenBorders.y));
		spawnDandelion(pos);

func spawnSeed(newPosition, seedRotation, newFlower):
	if isGameOver:
		return;
	var newSeed = seedScene.instantiate();
	newSeed.newFlower = newFlower;
	newSeed.position = newPosition;
	newSeed.rotation = seedRotation;
	add_child(newSeed);


func spawnDandelion(newPosition):
	if isGameOver:
		return;
	var newDandelion = dandelionScene.instantiate();
	newDandelion.position = newPosition;
	add_child(newDandelion);

	
func shootBullet(vec, bulletPosition):
	if isGameOver:
		return;
	var newBullet = bulletScene.instantiate();
	newBullet.direction = vec;
	newBullet.position = bulletPosition;
	add_child(newBullet);
	
func shootSeedBullet(seedPosition, seedRotation):
	if isGameOver:
		return;
	var newSeedBullet = seedBulletScene.instantiate();
	newSeedBullet.position = seedPosition;
	newSeedBullet.rotation = seedRotation;
	add_child(newSeedBullet);
	
func spawnTurret(newPosition):
	if isGameOver:
		return;
	var newTurret = turretScene.instantiate();
	newTurret.position = newPosition;
	add_child(newTurret);
	
func gameOver():
	for _i in self.get_children():
		_i.queue_free();
	get_tree().change_scene_to_packed(gameOverScene);
	get_tree().paused = true;
	pass;
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawnTimer += delta;
	elapsedTime += delta;
	if spawnTimer >= spawnSeparation:
		var pos = Vector2(randi_range(0, screenBorders.x),randi_range(0, screenBorders.y));
		spawnDandelion(pos);
		spawnTimer = 0;
		spawnSeparation = max(spawnSeparation - 1, 3);
	pass
