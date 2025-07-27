class_name ConsumableManager extends Node
@onready var mCharacterRegister: CharacterRegister = get_node("../CharacterRegister");
@onready var mDisplayManager: CharacterDisplayController = get_node("../GameUI/CharacterDisplayController");

func ProcessConsume(item: InvItem):
	if !item:
		return;
	mCharacterRegister.mActiveCharacter.CurrentHealth += item.HealAmount;
	mDisplayManager.UpdatePlayerHealthVisual();
