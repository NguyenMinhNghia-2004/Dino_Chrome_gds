extends CharacterBody2D

const SPEED = 1.0
const JUMP_VELOCITY = -660.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	
	if is_on_floor():
		if not get_parent().game_running:
			$Ice_avt.play("idle")
		else:
			$run.disabled = false
			if Input.is_action_pressed("jump"):
				$jump_ef.play()
				velocity.y = JUMP_VELOCITY
			elif Input.is_action_pressed("duck"):
				$Ice_avt.play("duck")
				$run.disabled = true
				$duck0.disabled = false
				$duck1.disabled = false
				velocity.y = 1000
				
			else:
				$run.disabled = false
				$duck0.disabled = true
				$duck1.disabled = true
				$Ice_avt.play("run")
	else  :
		$duck0.disabled = true
		$duck1.disabled = true
		$run.disabled = false
		$Ice_avt.play("jump")
		if Input.is_action_just_pressed("duck"):
			
			$run.disabled = true
			$duck0.disabled = false
			$duck1.disabled = false
			velocity.y = 1000
		
	move_and_slide()
