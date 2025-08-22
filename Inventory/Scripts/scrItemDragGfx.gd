class_name ItemDragGfxHandler extends Control
@export var DraggedItemUIOffset: Vector2;
@onready var mItemSlot: InvSlot = InvSlot.new(); 
@onready var mItemSlotUI: SlotUI = $InvSlotUI
var mIsItemHeld: bool = false;

func _ready() -> void:
	mItemSlotUI.update(mItemSlot)
	mItemSlotUI.visible = false;

func _process(delta: float) -> void:
	if mIsItemHeld:
		var mouse_pos = get_viewport().get_mouse_position()
		var local_mouse_pos = mItemSlotUI.get_parent().get_local_mouse_position()
		mItemSlotUI.position = local_mouse_pos + DraggedItemUIOffset;

func OnItemDragged(_Slot: InvSlot):
	# Take item from Inventory
	mItemSlot.item = _Slot.item;
	mItemSlot.amount = _Slot.amount;
	_Slot.item = null;
	_Slot.amount = 0;
	# If we took anything, update our drag GFX
	if mItemSlot.item:
		mItemSlotUI.update(mItemSlot)
		mItemSlotUI.visible = true;
		mIsItemHeld = true;
	
func OnItemDropped(_Slot: InvSlot):
	# Place Item into Inventory
	_Slot.item = mItemSlot.item
	_Slot.amount = mItemSlot.amount;
	_Slot.DropToSlot()
	mItemSlot.item = null;
	mItemSlot.amount = 0;
	#UpdateSlotGFX
	mItemSlotUI.update(mItemSlot)
	mItemSlotUI.visible = false;
	mIsItemHeld = false;
