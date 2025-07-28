class_name DamageNumberBehavior extends Label
@export var mMaxSpeed: Vector2;
@export var fade_duration: float = 1.0 # Time in seconds for the fade effect
@export var move_duration: float = 1.0 # Time in seconds for the movement

var mVelocity: Vector2;
var mIsMovingRight: bool;
var time_elapsed: float = 0.0

func _ready() -> void:
	mVelocity = mMaxSpeed;
	if randi_range(0,2) == 0:
		mIsMovingRight = true;
		mVelocity.x *= -1;
		rotation_degrees = 15
	else:
		rotation_degrees = -15

func _process(delta: float) -> void:
	#Update elapsed time
	time_elapsed += delta
	
	# Apply velocity to label
	mVelocity.x *= .98
	mVelocity.y *= .96
	
	# Move the label
	if time_elapsed <= move_duration:
		position += mVelocity * delta
	
	# Apply fade effect
	if time_elapsed <= fade_duration:
		var alpha = 1.0 - (time_elapsed / fade_duration) # Linearly interpolate alpha from 1 to 0
		modulate.a = alpha
	else:
		# Optional: Remove the label after fading out
		queue_free()
