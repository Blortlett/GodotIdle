class_name CraftableSlotUI extends Node
@export var mInvSlotUI: SlotUI
var mInvSlot: InvSlot = InvSlot.new()

func SetDisplayItem(_Item: InvItem):
	mInvSlot.item = _Item
	print_debug(mInvSlotUI)
	mInvSlotUI.update(mInvSlot)
