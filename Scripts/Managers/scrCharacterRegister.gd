extends Node

class_name CharacterRegister
@export var mActiveCharacter: Character;
var mActiveEnemyCharacter: Character;

@onready var mInventoryUI: InventoryUI = get_node("../GameUI");
@onready var mCombatManager: CombatManager = get_node("../CombatManager");
@onready var mCharacterDisplayController: CharacterDisplayController = get_node("../GameUI/CharacterDisplayController");
@onready var mAreaManager: AreaManager = get_node("../AreaManager");

signal NewEnemySpawn;

func _ready() -> void:
	mActiveCharacter.mPlayerType = Character.PlayerType.PLAYER;
	mActiveCharacter.InitCharacter();
	mCharacterDisplayController.SetPlayerUI(mActiveCharacter);


func KillEnemy() -> InvItem:
	StartRespawnDelay();
	var ItemLoot: InvItem = mActiveEnemyCharacter.Die();
	mCombatManager.EndCombat();
	return ItemLoot;


func StartRespawnDelay(delay: float = 3.0) -> void:
	await get_tree().create_timer(delay).timeout;
	RespawnEnemy();

func RespawnEnemy() -> void:
	var spawnableEnemies = mAreaManager.mCurrentArea.SpawnableEnemies
	
	# Pick Random Enemy
	var RandomEnemyInt = randi_range(0, spawnableEnemies.size() - 1);
	mActiveEnemyCharacter = spawnableEnemies[RandomEnemyInt];
	# Setup EnemyStats / Display
	mActiveEnemyCharacter.InitCharacter();
	mCharacterDisplayController.SetEnemyUI(mActiveEnemyCharacter);
	# engage combat
	NewEnemySpawn.emit();
	mCombatManager.BeginCombat();

func ClearEnemySlot() -> void:
	#mActiveEnemyCharacter.queue_free();
	mCombatManager.EndCombat();
