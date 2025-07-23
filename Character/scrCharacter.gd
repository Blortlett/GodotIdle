extends Node

class_name Character
enum CharacterType
{
	WARRIOR,
	ROGUE,
	MAGE
}

var mHP: float;
var mMana: float;
var mSprite: SpriteFrames;
var mCharacterType: CharacterType;

class Warrior extends Character:
		func _ready():
			mHP = 150;
			mMana = 20;
			mSprite = load("res://Character/Sprites/sprfWarrior.tres") as SpriteFrames;
			mCharacterType = CharacterType.WARRIOR;

class Ranger extends Character:
		func _ready():
			mHP = 100;
			mMana = 20;
			mSprite = load("res://Character/Sprites/sprfRanger.tres") as SpriteFrames;
			mCharacterType = CharacterType.ROGUE;

class Mage extends Character:
	func _ready():
		mHP = 100;
		mMana = 20;
		mSprite = load("res://Character/Sprites/sprfMage.tres") as SpriteFrames;
		mCharacterType = CharacterType.MAGE;

class Orc extends  Character:
	func _ready() -> void:
		mHP = 120;
		mMana = 20;
