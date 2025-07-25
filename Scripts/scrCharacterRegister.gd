extends Node

class_name CharacterRegister

@export var mSpawnableEnemies: Array[Character];

@export var mActiveCharacter: Character;
var mActiveEnemyCharacter: Character;

@onready var mInventoryUI: InventoryUI = get_node("../InventoryUI");
@onready var mCombatManager: CombatManager = get_node("../CombatManager");

signal NewEnemySpawn;

func _ready() -> void:
	mActiveCharacter.InitCharacter();
	mInventoryUI.SetPlayerUI(mActiveCharacter);


func KillEnemy() -> InvItem:
	StartRespawnDelay();
	var ItemLoot: InvItem = mActiveEnemyCharacter.Die();
	mCombatManager.EndCombat();
	return ItemLoot;


func StartRespawnDelay(delay: float = 3.0) -> void:
	await get_tree().create_timer(delay).timeout;
	RespawnEnemy();

func RespawnEnemy() -> void:
	# Pick Random Enemy
	var RandomEnemyInt = randi_range(0, mSpawnableEnemies.size() - 1);
	mActiveEnemyCharacter = mSpawnableEnemies[RandomEnemyInt];
	# Setup EnemyStats / Display
	mActiveEnemyCharacter.InitCharacter();
	mInventoryUI.SetEnemyUI(mActiveEnemyCharacter);
	
	NewEnemySpawn.emit();
	mCombatManager.BeginCombat();

func ClearEnemySlot() -> void:
	mActiveEnemyCharacter.queue_free();
	mCombatManager.EndCombat();
