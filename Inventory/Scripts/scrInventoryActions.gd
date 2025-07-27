class_name InventoryActions extends Control
# Item drag graphics
@onready var mDragHandler: ItemDragGfxHandler = get_node("ItemDragGfxHandler");
# Inventory UI
@onready var mInventoryGrid: GridContainer = get_node("../InventoryGrid");
@onready var mInventorySlots: Array[Node] = mInventoryGrid.get_children();
# Inventory Object
@onready var mInventoryUI: InventoryUI = get_node("../../..")
@onready var mEquipmentUI: EquipmentManager = get_node("../../CharacterUI/EquipmentUI")
@onready var mInventory: Inv = mInventoryUI.GetInventory();

var mIsItemHeld: bool = false;

func _ready() -> void:
	# Sign up to InventoryUI interaction signals
	for i in mInventorySlots.size():
		var slot = mInventorySlots[i]
		var button := slot.get_node("CenterContainer/Button")
		button.pressed.connect(func(): OnInventoryClicked(i))
	# Sign up to EquipmentUI interaction signals
	var EquipmentSlots: Array[SlotUI] = mEquipmentUI.GetUISlots()
	print_debug("EquipmentSlots size: " + str(EquipmentSlots.size()))
	for i in EquipmentSlots.size():
		var slot = EquipmentSlots[i]
		var button := slot.get_node("CenterContainer/Button")
		button.pressed.connect(func(): OnEquipmentClicked(i))

func OnInventoryClicked(slot_index: int):
	# Debug
	print_debug("Clicked inventory slot index: %d" % slot_index)
	
	# Drop held Item to slot
	if mIsItemHeld:
		mDragHandler.OnItemDropped(mInventoryUI.GetInventory().slots[slot_index])
		mInventoryUI.UpdateSlots(); # Update Inventory UI
		mIsItemHeld = false;
	# Try Pickup item from slot
	else:
		var slot = mInventoryUI.GetInventory().slots[slot_index]
		if slot.amount == 0 or !slot.item:
			return
		mDragHandler.OnItemDragged(slot)
		mInventoryUI.UpdateSlots(); # Update Inventory UI
		mIsItemHeld = true;

func OnEquipmentClicked(slot_index: int):
	# Debug
	print_debug("Clicked equipment slot index: %d" % slot_index)
	
	# Drop held Item to slot
	if mIsItemHeld:
		mDragHandler.OnItemDropped(mEquipmentUI.GetInventory().slots[slot_index])
		mEquipmentUI.UpdateSlots(); # Update Inventory UI
		mIsItemHeld = false;
	# Try Pickup item from slot
	else:
		var slot = mEquipmentUI.GetInventory().slots[slot_index]
		if slot.amount == 0 or !slot.item:
			return
		mDragHandler.OnItemDragged(slot)
		mEquipmentUI.UpdateSlots(); # Update Inventory UI
		mIsItemHeld = true;


func OnSlotClicked(inventory: Inv, slot_index: int):
	# Drop held Item to slot
	if mIsItemHeld:
		mDragHandler.OnItemDropped(mEquipmentUI.GetInventory().slots[slot_index])
		mEquipmentUI.UpdateSlots(); # Update Inventory UI
		mIsItemHeld = false;
	# Try Pickup item from slot
	else:
		var slot = mEquipmentUI.GetInventory().slots[slot_index]
		if slot.amount == 0 or !slot.item:
			return
		mDragHandler.OnItemDragged(slot)
		mEquipmentUI.UpdateSlots(); # Update Inventory UI
		mIsItemHeld = true;
