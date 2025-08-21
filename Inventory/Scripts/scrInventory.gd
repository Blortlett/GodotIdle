class_name Inv extends Resource
@export var slots: Array[InvSlot];
signal update;

#insert item into first spot in inventory. will stack
func insert(item: InvItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1;
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item;
			emptySlots[0].amount = 1;
	update.emit();

func GetAllItems() -> Array[InvItem]:
	var HeldItems: Array[InvItem]
	for slot: InvSlot in slots:
		if slot.item:
			HeldItems.append(slot.item)
	return HeldItems
