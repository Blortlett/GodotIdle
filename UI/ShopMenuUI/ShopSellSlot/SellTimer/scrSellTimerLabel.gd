class_name SellTimerLabel extends Node
@onready var SellTimerText: Label = get_node("Label")
var mParentShop;
var mSellSlotID: int;
var mSellTimer: float = 0;

func _ready() -> void:
	self.visible = false;
	SellTimerText.text = "0s"
	process_mode = Node.PROCESS_MODE_DISABLED

func StartTimer(_Time: float):
	mSellTimer = _Time
	self.visible = true;
	process_mode = Node.PROCESS_MODE_PAUSABLE

func OnTimerEnd():
	self.visible = false;
	SellTimerText.text = "0s"
	mParentShop.OnItemSell(mSellSlotID)
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	mSellTimer -= delta;
	SellTimerText.text = str(int(mSellTimer)) + "s"
	if mSellTimer < 0:
		OnTimerEnd()
