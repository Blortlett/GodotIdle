extends Control;

class_name InventoryUI;
@onready var inv: Inv = preload("res://Inventory/PlayerInventory.tres");
@onready var slots: Array = $RightPageUI/InventoryUI/InventoryGrid.get_children();
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

func GetInventory() -> Inv:
	return inv;
