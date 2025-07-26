class_name EquipmentManager extends Node
# Inventory Component
@onready var mInventory: Inv = preload("res://Inventory/PlayerEquipmentInventory.tres");
var isOpen = true;

# Inventory UI
@onready var mSlotContainer: Control = $Slots
@export var mArmorSlotsUI: Array[SlotUI]
@export var mWeaponSlotUI: SlotUI
@export var mAccessorySlotUI: SlotUI

func _ready() -> void:
	mInventory.update.connect(UpdateSlots);
	UpdateSlots();
	open();

func UpdateSlots():
	print_debug(mInventory.slots.size())
	# Update Armor Slots
	for i in range(4):
		mArmorSlotsUI[i].update(mInventory.slots[i])
	# Update other slots
	mWeaponSlotUI.update(mInventory.slots[4])
	mAccessorySlotUI.update(mInventory.slots[5])

func open():
	mSlotContainer.visible = true;
	isOpen = true;

func close():
	mSlotContainer.visible = false;
	isOpen = false;

func GetInventory() -> Inv:
	return mInventory;
