extends Node

export(PackedScene) var obstacle_scene

func _ready():
	randomize()


func _on_ObstacleTimer_timeout():
	# Create a new instance of the Mob scene.
	var obstacle = obstacle_scene.instance()

	# Choose a random location on Path2D.
	var obstacle_spawn_location = get_node("ObstaclePath/ObstacleSpawnLocation")
	obstacle_spawn_location.offset = randi()

	# Set the obstacle's direction perpendicular to the path direction.S
	var direction = obstacle_spawn_location.rotation + PI / 2

	# Set the obstacle's position to a random location.
	obstacle.position = obstacle_spawn_location.position

	# Choose the velocity for the obstacle.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	obstacle.linear_velocity = velocity.rotated(direction)

	# Spawn the obstacle by adding it to the Main scene.
	add_child(obstacle)
