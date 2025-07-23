extends Node

class_name Character

enum Faction
{
	ALLIANCE,
	HORDE
}

enum CharacterType
{
	WARRIOR,
	ROGUE,
	MAGE
}

var mHP: float;
var mAttackDmg: float;
var mMagicAttackDmg: float;
var mDefense: float;
var mMagicDefense: float;
var mSprite: SpriteFrames;
var mCharacterType: CharacterType;
var mFaction: Faction;

# -= Heroes =-

class Warrior extends Character:
		func _ready():
			mHP = 100;
			mAttackDmg = 13;
			mMagicAttackDmg = 0;
			mDefense = 8;
			mMagicDefense = 3;
			mSprite = load("res://Character/Sprites/GoodGuys/sprfWarrior.tres") as SpriteFrames;
			mCharacterType = CharacterType.WARRIOR;
			mFaction = Faction.ALLIANCE;

class Ranger extends Character:
		func _ready():
			mHP = 80;
			mAttackDmg = 8;
			mMagicAttackDmg = 5;
			mDefense = 5;
			mMagicDefense = 4;
			mSprite = load("res://Character/Sprites/GoodGuys/sprfRanger.tres") as SpriteFrames;
			mCharacterType = CharacterType.ROGUE;
			mFaction = Faction.ALLIANCE;

class Mage extends Character:
	func _ready():
		mHP = 70;
		mAttackDmg = 2;
		mMagicAttackDmg = 20;
		mDefense = 2;
		mMagicDefense = 14;
		mSprite = load("res://Character/Sprites/GoodGuys/sprfMage.tres") as SpriteFrames;
		mCharacterType = CharacterType.MAGE;
		mFaction = Faction.ALLIANCE;

# -= Enemies =-
class Orc extends  Character:
	func _ready() -> void:
		mHP = 120;
		mAttackDmg = 8;
		mMagicAttackDmg = 0;
		mDefense = 6;
		mMagicDefense = 2;
		mSprite = load("res://Character/Sprites/BadGuys/sprfOrc.tres") as SpriteFrames;
		mCharacterType = CharacterType.WARRIOR;
		mFaction = Faction.HORDE;

class Slime extends  Character:
	func _ready() -> void:
		mHP = 40;
		mAttackDmg = 4;
		mMagicAttackDmg = 4;
		mDefense = 3;
		mMagicDefense = 3;
		mSprite = load("res://Character/Sprites/BadGuys/sprfSlime.tres") as SpriteFrames;
		mCharacterType = CharacterType.WARRIOR;
		mFaction = Faction.HORDE;
