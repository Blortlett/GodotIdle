extends Node

class_name CharacterRegister

@export var mCharacterSlots: Array[Character];
var mActiveCharacter: Character;

func _ready() -> void:
	mCharacterSlots[0] = Character.Warrior.new();
	mCharacterSlots[1] = Character.Ranger.new();
	mCharacterSlots[2] = Character.Mage.new();
	mActiveCharacter = mCharacterSlots[0];
