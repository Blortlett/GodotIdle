extends Control;

class_name InventoryUI;

@onready var inv: Inv = preload("res://Inventory/PlayerInventory.tres");
@onready var slots: Array = $BookRightPageSprite/CharacterUI/InventoryGrid.get_children();
@onready var PlayerDisplay: CharacterDisplay = $BookRightPageSprite/CharacterUI/CharacterDisplay;
@onready var EnemyDisplay: CharacterDisplay = $BookLeftPageSprite/CharacterDisplay;

var isOpen = false;

func _ready() -> void:
	inv.update.connect(UpdateSlots);
	UpdateSlots();
	open();

func UpdateSlots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func open():
	visible = true;
	isOpen = true;

func close():
	visible = false;
	isOpen = false;

func GetInventorty() -> Inv:
	return inv;



# -= Character Displays =-
func SetPlayerUI(_Character: Character):
	PlayerDisplay.SetCharacter(_Character);

func SetEnemyUI(_Character: Character):
	EnemyDisplay.SetCharacter(_Character);
