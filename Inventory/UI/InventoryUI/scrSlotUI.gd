class_name SlotUI extends Panel

@export var mItemVisual: Sprite2D;
@export var mAmountText: Label;
@export var mIsEquipmentSlot: bool;
@export var mEquipmentType: InvItem.ArmorSlot;

func update(slot: InvSlot):
	if !slot.item:
		mItemVisual.visible = false;
		mAmountText.visible = false;
	else:
		mItemVisual.visible = true;
		# Set item sprite from ItemID
		var xPos : int = ((slot.item.ItemID % 16)) * 32;
		var yPos: int = (slot.item.ItemID / 16) * 32;
		var regionPosition : Vector2 = Vector2(xPos, yPos);
		mItemVisual.region_rect.position = regionPosition;
		#Set Amount text
		mAmountText.text = str(slot.amount);
		if (slot.amount > 1):
			mAmountText.visible = true;
		else:
			mAmountText.visible = false;
