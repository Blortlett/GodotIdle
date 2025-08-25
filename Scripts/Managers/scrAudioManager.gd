class_name AudioManager extends Node
@onready var PlayerAttackAudioPlayer: AudioStreamPlayer = get_tree().get_root().get_node("Node/AudioPlayers/PlayerAttackAudioStreamPlayer")
@onready var PlayerHitAudioPlayer: AudioStreamPlayer = get_tree().get_root().get_node("Node/AudioPlayers/PlayerHitAudioStreamPlayer")
@onready var EnemyAttackAudioPlayer: AudioStreamPlayer = get_tree().get_root().get_node("Node/AudioPlayers/EnemyAttackAudioStreamPlayer")
@onready var EnemyHitAudioPlayer: AudioStreamPlayer = get_tree().get_root().get_node("Node/AudioPlayers/EnemyHitAudioStreamPlayer")

@onready var mCharacterRegister: CharacterRegister = get_tree().get_root().get_node("Node/CharacterRegister")

func PlayerAttackPlayAudio():
	if mCharacterRegister.mActiveCharacter.mAttackSound:
		var audioIndex = randi_range(0, 2)
		var AttackSound: AudioStream = mCharacterRegister.mActiveCharacter.mAttackSound[audioIndex]
		PlayerAttackAudioPlayer.stream = AttackSound
		PlayerAttackAudioPlayer.play()

func PlayerHitPlayAudio():
	if mCharacterRegister.mActiveCharacter.mHitSound:
		var audioIndex = randi_range(0, 2)
		var HitSound: AudioStream = mCharacterRegister.mActiveCharacter.mHitSound[audioIndex]
		PlayerHitAudioPlayer.stream = HitSound
		PlayerHitAudioPlayer.play()

func EnemyAttackPlayAudio():
	if mCharacterRegister.mActiveEnemyCharacter.mAttackSound:
		var audioIndex = randi_range(0, 2)
		var AttackSound: AudioStream = mCharacterRegister.mActiveEnemyCharacter.mAttackSound[audioIndex]
		EnemyAttackAudioPlayer.stream = AttackSound
		EnemyAttackAudioPlayer.play()

func EnemyHitPlayAudio():
	if mCharacterRegister.mActiveEnemyCharacter.mHitSound:
		var audioIndex = randi_range(0, 2)
		var HitSound: AudioStream = mCharacterRegister.mActiveEnemyCharacter.mHitSound[audioIndex]
		EnemyHitAudioPlayer.stream = HitSound
		EnemyHitAudioPlayer.play()
