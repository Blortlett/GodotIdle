extends Resource

class_name InvItem
enum ItemType
{
	ARMOR, WEAPON, CONSUMABLE, QUEST, MATERIAL
}
enum CombatType
{
	NONE, MAGIC, RANGED, MELEE
}
enum ArmorSlot
{
	NONE, HELMET, CHEST, LEG, BOOTS, ACCESSORY, WEAPON
}

@export var name: String = "";
@export var texture: Texture2D = preload("res://Art/Items/Items32x32.png");
@export var ItemID: int;
@export var mItemType: ItemType;
@export var mArmorSlot: ArmorSlot;
@export var mCombatType: CombatType;
@export var DamageModifier: float;
@export var MagicDamageModifier: float;
@export var DefenseModifier: float;
@export var MagicDefenseModifier: float;
@export var HealAmount: float;
@export var TimeToSell: float = 9;
