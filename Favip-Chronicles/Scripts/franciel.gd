extends CharacterBody2D

@export_category("Variables")
@export var velocidade: float = 64.0
@export var aceleracao: float = 1.0
@export var atrito: float = 1.0

var ultima_direcao: Vector2 = Vector2.DOWN
@onready var animation_player: AnimationPlayer = $AnimationFranciel

func andar() -> void:
	var direcao = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direcao != Vector2.ZERO:
		ultima_direcao = direcao.normalized()
		var alvo = ultima_direcao * velocidade
		velocity.x = lerp(velocity.x, alvo.x, aceleracao)
		velocity.y = lerp(velocity.y, alvo.y, aceleracao)
		if abs(ultima_direcao.x) > abs(ultima_direcao.y):
			if ultima_direcao.x > 0:
				animation_player.play("Move_Right")
			else:
				animation_player.play("Move_Left")
		else:
			if ultima_direcao.y > 0:
				animation_player.play("Move_Down")
			else:
				animation_player.play("Move_Up")
	else:
		velocity.x = lerp(velocity.x, 0.0, atrito)
		velocity.y = lerp(velocity.y, 0.0, atrito)

		# Tocar animação idle com base na última direção
		if abs(ultima_direcao.x) > abs(ultima_direcao.y):
			if ultima_direcao.x > 0:
				animation_player.play("Idle_Down")
			else:
				animation_player.play("Idle_Down")
		else:
			if ultima_direcao.y > 0:
				animation_player.play("Idle_Down")
			else:
				animation_player.play("Idle_Up")

func _physics_process(_delta: float) -> void: # "Main"
	andar()
	move_and_slide()
