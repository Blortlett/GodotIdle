class_name Inv extends Resource
@export var slots: Array[InvSlot];
signal update;

#insert item into first spot in inventory. will stack
func insert(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	# If item exists in inventory already, and item to insert is not a weapon or armor piece
	if !itemSlots.is_empty() && item.mItemType != InvItem.ItemType.WEAPON && item.mItemType != InvItem.ItemType.ARMOR:
		itemSlots[0].amount += 1;
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item;
			emptySlots[0].amount = 1;
	update.emit();

func CheckHasItems(_item: ItemAmount) -> bool:
	var itemSlots = slots.filter(func(slot): return slot.item == _item.Item)
	var itemCount: int = 0
	for slot: InvSlot in itemSlots:
		itemCount += slot.amount
	if itemCount >= _item.Amount:
		return true;
	else:
		return false;

func remove(_item: ItemAmount):
	var itemSlots = slots.filter(func(slot): return slot.item == _item.Item)
	itemSlots[0].amount -= _item.Amount;
	if itemSlots[0].amount <= 0:
		itemSlots[0].item = null
	update.emit();
	# Need to figure out a way to clear inv slot here...?

func GetAllItems() -> Array[InvItem]:
	var HeldItems: Array[InvItem]
	for slot: InvSlot in slots:
		if slot.item:
			HeldItems.append(slot.item)
	return HeldItems
