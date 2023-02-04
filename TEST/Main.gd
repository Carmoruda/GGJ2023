extends Node

export(PackedScene) var mob_scene
export(PackedScene) var topmob_scene
var score
var hp = 3 setget set_hp

signal hp_changed

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$Player.hide()

func new_game():
	score = 0
	hp = 3
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.update_hp(hp)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	var topmob = topmob_scene.instance()
	topmob.position = Vector2(0,0)
	
	add_child(topmob)
	
	$MobTimer.start()
	$ScoreTimer.start()
	$TopShowTimer.start()

func _on_TopShowTimer_timeout():
	var topmob = topmob_scene.instance()

func set_hp ( new_hp ):
	emit_signal("hp_changed", new_hp)
	hp = new_hp
	$HUD.update_hp(hp)
	if hp <= 0:
		game_over()
		
func damage():
	if hp != 0:
		set_hp(hp - 1)
	
	

