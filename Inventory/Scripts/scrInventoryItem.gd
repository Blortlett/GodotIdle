extends Resource

class_name InvItem
enum ItemType
{
	ARMOR, WEAPON, CONSUMABLE, QUEST, MATERIAL
}
enum ArmorSlot
{
	NONE, HELMET, CHEST, LEG, BOOTS, ACCESSORY, WEAPON
}

@export var name: String = "";
@export var texture: Texture2D;
@export var ItemID: int;
@export var mItemType: ItemType;
@export var mArmorSlot: ArmorSlot;
@export var DamageModifier: float;
@export var MagicDamageModifier: float;
@export var DefenseModifier: float;
@export var MagicDefenseModifier: float;
@export var HealAmount: float;
