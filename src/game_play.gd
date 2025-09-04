extends Node

var stump_scene = preload("res://Sence/object/bush.tscn")
var rock_scene = preload("res://Sence/object/stone.tscn")
var barrel_scene = preload("res://Sence/object/barrel.tscn")
var bird_scene = preload("res://Sence/object/bird.tscn")
var obstacle_types := [stump_scene, rock_scene, barrel_scene]
var obstacles : Array
var bird_heights := [200, 300]

const Dino_start_pos := Vector2i(150,596)
const  Cam_start_pos := Vector2i(576,324)

var game_running: bool

var score : int
var high_score : int =0
const SCORE_MODIFIER : int = 10

var speed : float
var speed_by_time : float = 0
var start_speed : float = 0.2
var max_speed : float = 5
const SPEED_MODIFIER : int = 6000

var difficulty 
var ground_height : int
const MAX_DIFFICULTY : int = 2

var last_obs
var screen_size: Vector2i
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	$GameOver.get_node("Button").pressed.connect(new_game)
	new_game()
	
func new_game():
	# Xóa tất cả các obs cũ trước khi reset game
	for obs in obstacles:
		if is_instance_valid(obs):
			obs.queue_free()
	obstacles.clear()
	
	speed_by_time = 0
	score = 0
	show_score()
	game_running = false
	get_tree().paused = false

	difficulty = 0

	$Dino_ice.position = Dino_start_pos
	$Dino_ice.velocity = Vector2i(0,0)
	$Ground.position = Vector2i(0,0)
	$Camera.position = Cam_start_pos

	$GameOver.hide()
	$HUD.get_node("StartLabel").show()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_running:
		
		speed = start_speed + speed_by_time
		if speed > max_speed:
			speed = max_speed
		
		#generate obstacles
		generate_obs()
		
		$Dino_ice.position.x += speed
		$Camera.position.x += speed
		$Shadow.position.x += speed
		$border.position.x += speed
		
		score += speed*5
		show_score()
		check_high_score()
		#update ground position
		if $Camera.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
		
		for obs in obstacles:
			if obs.position.x < ($Camera.position.x - screen_size.x):
				remove_obs(obs)
		
	else :
		if Input.is_action_pressed("jump"):
			game_running = true
			$HUD.get_node("StartLabel").hide()
	speed_by_time += 0.00001


func show_score():
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score / SCORE_MODIFIER)

func generate_obs():
	#generate ground obstacles
	if obstacles.is_empty() or (last_obs != null and last_obs.position.x < score + randi_range(300, 500)):
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		var max_obs : int = difficulty + 1
		for i in range(randi() % max_obs + 1):
			obs = obs_type.instantiate()
			var sprite_node = obs.get_node_or_null("Sprite2D")
			var obs_height = 0
			var obs_scale = Vector2(1,1)
			if sprite_node != null:
				obs_height = sprite_node.texture.get_height()
				obs_scale = sprite_node.scale
			# Đặt y sao cho đáy sprite nằm trên mặt đất
			var obs_x : int = screen_size.x + score + 100 + (i * 100)
			var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y/3) 
			last_obs = obs
			add_obs(obs, obs_x, obs_y)
		#additionally random chance to spawn a bird
		if difficulty == MAX_DIFFICULTY:
			if (randi() % 2) == 0:
				#generate bird obstacles
				obs = bird_scene.instantiate()
				var obs_x : int = screen_size.x + score + 100
				var obs_y : int = bird_heights[randi() % bird_heights.size()]
				add_obs(obs, obs_x, obs_y)

func adjust_difficulty():
	difficulty = speed_by_time*10
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	if obs.has_signal("body_entered"):
		obs.body_entered.connect(hit_obs)
	add_child(obs)
	obstacles.append(obs)

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)
	
func hit_obs(body):
	if body.name == "Dino_ice":
		game_over()

func check_high_score():
	if score > high_score:
		high_score = score
		$HUD.get_node("HighScoreLabel").text = "HIGH SCORE: " + str(high_score / SCORE_MODIFIER)

func game_over():
	check_high_score()
	get_tree().paused = true
	game_running = false
	$GameOver.show()
