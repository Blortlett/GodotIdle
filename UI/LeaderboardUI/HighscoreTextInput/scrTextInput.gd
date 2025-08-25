class_name TextInput extends Control

@onready var name_input: LineEdit = $NameInput
@onready var submit_button: Button = $SubmitButton
@onready var mPlayerData: PlayerData = get_tree().get_root().get_node("Node/PlayerData")
# Leaderboard controller script
var mLeaderboardController: Leaderboard

func GetName():
	self.visible = true
	# Configure the LineEdit for mobile input
	name_input.virtual_keyboard_enabled = true
	name_input.max_length = 9  # Optional: limit name length
	
	# Connect signals
	name_input.text_submitted.connect(_on_name_submitted)
	submit_button.pressed.connect(_on_submit_pressed)
	
	# Auto-focus the input field to show keyboard immediately
	name_input.grab_focus()


func _on_name_submitted(text: String):
	# Called when player presses Enter/Done on keyboard
	#save_highscore(text)
	name_input.virtual_keyboard_enabled = false;

func _on_submit_pressed():
	# Called when submit button is pressed
	var player_name = name_input.text.strip_edges()
	if player_name.length() > 0:
		save_highscore(player_name)
		self.visible = false;
	else:
		# Show error message for empty name
		print("Please enter a name")

func save_highscore(player_name: String):
	# Highscore saving logic here
	print("Saving highscore for: ", player_name)
	var NewHighscore = HighscoreData.new()
	NewHighscore.PlayerName = player_name
	NewHighscore.EnemyKills = mPlayerData.mEnemiesKilled
	NewHighscore.CashCollected = mPlayerData.mPlayerMoney
	NewHighscore.CalculateFinalScore()
	mLeaderboardController.SaveHighscore(NewHighscore)
