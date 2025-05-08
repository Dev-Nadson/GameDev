extends CharacterBody2D

@export_category("Variables")
@export var velocidade: float = 64.0 #Declarando a velocidade
@export var aceleracao: float = 1.0
@export var atrito: float = 1.0
	
func andar() -> void: #Função movimento
	var direcao: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"), #Controles WASD E Setinhas
		Input.get_axis("move_up", "move_down")
	)
	print(direcao) #Printa no terminal
	
	if direcao != Vector2.ZERO: #quando estiver em movimento
		velocity.x = lerp(velocity.x, direcao.normalized().x * velocidade, aceleracao)
		velocity.y = lerp(velocity.y, direcao.normalized().y * velocidade, aceleracao)
		return
	velocity.x = lerp(velocity.x, direcao.normalized().x * velocidade, atrito)
	velocity.y = lerp(velocity.y, direcao.normalized().y * velocidade, atrito)
	velocity = direcao.normalized() * velocidade #Velocity é palavra reservada

	
func _physics_process(_delta: float) -> void: #Seria a "Main"
	andar() 
	move_and_slide() #para mover de forma suave
