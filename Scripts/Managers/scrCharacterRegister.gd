extends Node

class_name CharacterRegister
@export var mActiveCharacter: Character;
var mActiveEnemyCharacter: Character;

@export var mPlayerCharacters: Array[Character];

@onready var mInventoryUI: InventoryUI = get_node("../GameUI");
@onready var mCombatManager: CombatManager = get_node("../CombatManager");
@onready var mCharacterDisplayController: CharacterDisplayController = get_node("../GameUI/CharacterDisplayController");
@onready var mAreaManager: AreaManager = get_node("../AreaManager");

var RespawnTimer: Timer = null;
signal NewEnemySpawn;

func _ready() -> void:
	mActiveCharacter.mPlayerType = Character.PlayerType.PLAYER;
	mActiveCharacter.InitCharacter();
	mCharacterDisplayController.SetPlayerUI(mActiveCharacter);

func KillEnemy() -> Array[InvSlot]:
	StartRespawnDelay();
	var ItemLoot: Array[InvSlot] = mActiveEnemyCharacter.Die();
	mCombatManager.EndCombat();
	return ItemLoot;

func StartRespawnDelay(delay: float = 3.0) -> void:
	# If a timer already exists, cancel it
	if RespawnTimer != null:
		RespawnTimer.stop()
		RespawnTimer.queue_free()
	# Create and start new timer
	RespawnTimer = Timer.new()
	RespawnTimer.wait_time = delay
	RespawnTimer.one_shot = true
	add_child(RespawnTimer)
	RespawnTimer.timeout.connect(RespawnEnemy)
	RespawnTimer.start()

func CancelRespawnDelay():
	if RespawnTimer != null:
		RespawnTimer.stop()
		RespawnTimer.queue_free()
		RespawnTimer = null

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
