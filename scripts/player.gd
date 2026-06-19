extends CharacterBody2D

@export var speed = 400
var screen_size

@onready var sprite = $AnimatedSprite2D

func _ready():
	sprite.play("idle")
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		velocity.x += 1
		sprite.flip_h = false
		sprite.play("walk")
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		sprite.flip_h = true
		sprite.play("walk")
	else:
		sprite.play("idle")
	
	position += velocity * speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
