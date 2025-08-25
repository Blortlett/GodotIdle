extends Resource

class_name Character
enum PlayerType
{
	NPC,
	PLAYER
}
enum AllianceType
{
	Alliance,
	Horde
}

# Name and Descriptions
@export var Name: String = "";
@export var mPlayerType: PlayerType;
@export var Alliance: AllianceType;
@export var Sprite: SpriteFrames;


@export var Health: float;
@export var Damage: float;
@export var MagicDamage: float;
@export var Defense: float;
@export var MagicDefense: float;
@export var AttackSpeed: float;

@export var mLootTable: LootTable;

@export var mHitSound: Array[AudioStream]
@export var mAttackSound: Array[AudioStream]

var CharacterID: int;
var CurrentHealth: float;


func InitCharacter() -> void:
	CurrentHealth = Health;
	print_debug(Name + " ready to go. Health: " + str(CurrentHealth));

func Die() -> Array[InvSlot]:
	# return dropped loot
	var DroppedLoot = mLootTable.SpawnLootDrop()
	return DroppedLoot;
