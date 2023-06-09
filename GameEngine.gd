extends Node2D

@onready var seedScene = preload("res://Seed/Seed.tscn");
@onready var dandelionScene = preload("res://Dandelion/Dandelion.tscn");
@onready var bulletScene = preload("res://Bullets/PlayerBullet.tscn");
@onready var seedBulletScene = preload("res://Bullets/SeedBullet.tscn");
@onready var turretScene = preload("res://Turret/Turret.tscn");
@onready var gameOverScene = preload("res://GameOver/GameOver.tscn");
@onready var TutorialGameScene = preload("res://Tutorial/Tutorial.tscn");
@onready var TitleScreenScene = preload("res://TitleScreen/TitleScreen.tscn");
@onready var pauseScene = preload("res://PauseMenu/Pause.tscn").instantiate();
@onready var screenBorders = get_viewport().get_visible_rect().size;

@export var spawnCount = 4;
var isGameOver = true;
var spawnTimer = 0;
var elapsedTime = 0;
var dandelionKillCount = 0;
var turretKillCount = 0;
var spawnSeparation = 6;
var seedsCaught = 0;
var playerPosition;
var padding = 16;
var minX = padding * 4;
var minY = padding * 4;
var maxX: int;
var maxY: int;
var level = 1;
var levelTimer = 0;
var levelDelay = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	maxX = screenBorders.x - padding * 4;
	maxY = screenBorders.y - padding * 4;
	pass

func isWithinSpawnBorders(position):
	if position.x >= minX && position.x <= maxX && position.y >= minY && position.y <= maxY:
		return true;
	else:
		return false
	

func startGame():
	isGameOver = false;
	spawnTimer = 0;
	elapsedTime = 0;
	dandelionKillCount = 0;
	turretKillCount = 0;
	spawnSeparation = 6;
	seedsCaught = 0;
	playerPosition;
	level = 1;
	levelTimer = 0;
	levelDelay = 10;
	for i in range(0, spawnCount):
		var pos = Vector2(randi_range(minX, maxX),randi_range(minY, maxY));
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
	
func vectorToPlayer(objPosition):
	var vec = playerPosition - objPosition;
	return vec.normalized();
	
func gameOver():
	clearScene();
	get_tree().change_scene_to_packed(gameOverScene);
	get_tree().paused = true;
	isGameOver = true;
	pass;
	
func toTutorial():
	get_tree().change_scene_to_packed(TutorialGameScene);
	pass;
	
func toTitle():
	get_tree().change_scene_to_packed(TitleScreenScene);
	pass;
	
func clearScene():
	for _i in self.get_children():
		_i.queue_free();
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isGameOver:
		return
	levelTimer += delta;
	spawnTimer += delta;
	elapsedTime += delta;
	if spawnTimer >= spawnSeparation:
		var pos = Vector2(randi_range(minX, maxX),randi_range(minY, maxY));
		spawnDandelion(pos);
		spawnTimer = 0;
	if levelTimer >= levelDelay:
		level += 1;
		spawnSeparation = max(spawnSeparation - 1, 2);
		levelTimer = 0;
	pass


