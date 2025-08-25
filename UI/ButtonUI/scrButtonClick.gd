class_name BigButton extends Button
@onready var mAudioManager: AudioManager = get_tree().get_root().get_node("Node/AudioPlayers")
@onready var mButton: Button = self
@onready var mButtonPressedGFX = $ButtonGFXPushed
@onready var mButtonReleasedGFX = $ButtonGFXReleased

func _ready() -> void:
	mButton.button_down.connect(ButtonPress)
	mButton.button_up.connect(ButtonReleased)
	ButtonReleased()

func ButtonPress():
	mAudioManager.ButtonClickPlayAudio()
	mButtonPressedGFX.visible = true
	mButtonReleasedGFX.visible = false

func ButtonReleased():
	mButtonPressedGFX.visible = false
	mButtonReleasedGFX.visible = true
