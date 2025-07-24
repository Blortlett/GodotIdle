extends Node

class_name CharacterRegister

@export var mActiveCharacter: Character;
@export var mActiveEnemyCharacter: Character;

@onready var mInventoryUI: InventoryUI = get_node("../InventoryUI");
@onready var mCombatManager: CombatManager = get_node("../CombatManager");

func _ready() -> void:
	mActiveCharacter.InitCharacter();
	mActiveEnemyCharacter.InitCharacter();
	mInventoryUI.SetPlayerUI(mActiveCharacter)
	mInventoryUI.SetEnemyUI(mActiveEnemyCharacter)
