extends Area2D
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec)
var screen_size  # Size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta # delta = frame length. this ensures consistent movement speed thru all framerates
	position = position.clamp(Vector2.ZERO, screen_size) #restricts player to the size of the screen
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

@warning_ignore("unused_parameter")
func _on_body_entered(body):
	hide() #player disappears after being hit
	hit.emit() #calls the hit signal
	$CollisionShape2D.set_deferred("disabled", true) #Must be deferred as we can't change physics properties on a callback
