extends Node

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		GameManager.instance.game_over();
