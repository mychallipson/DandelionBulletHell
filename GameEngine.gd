extends Node2D

@onready var seedScene = preload("res://Seed/Seed.tscn");
@onready var dandelionScene = preload("res://Dandelion/Dandelion.tscn");
@onready var screenBorders = get_viewport().get_visible_rect().size;

@export var spawnCount = 3;
var seeds = [];
var dandelions = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, spawnCount):
		var pos = Vector2(randi_range(0, screenBorders.x),randi_range(0, screenBorders.y));
		spawnDandelion(pos);
	pass # Replace with function body.


func spawnSeed(newPosition, rotation, newFlower):
	var newSeed = seedScene.instantiate();
	newSeed.position = newPosition;
	newSeed.rotation = rotation;
	newSeed.newFlower = newFlower && dandelions.size() < 10;
	add_child(newSeed);
	seeds.append(newSeed);

func spawnDandelion(newPosition):
	var newDandelion = dandelionScene.instantiate();
	newDandelion.position = newPosition;
	add_child(newDandelion);
	dandelions.append(newDandelion);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
