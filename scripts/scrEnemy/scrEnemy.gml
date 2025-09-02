function enemy_create(){
	life_max = 30;
	life = life_max;
	velocity_horizontal = 0;
	velocity_vertical = 0;
	velocity = 1;
	gravity_var = 0.3;
	velocity_jump = 9;
}
// Quando o inimigo toma dano
function enemy_take_damage(){
	var _projectile = place_meeting(x, y, IDPROJECTILE)
	if(_projectile){
		life -= IDPROJECTILE.damage;
		instance_destroy(IDPROJECTILE);
	}
	
}
// Ataque do inigo

// como o inimigo pensa
function enemy_controller(_target = IDGOAL){
	var _is_on_ground = place_meeting(x, y + 1, IDBLOCK);
	var _jump, _direction;
	_jump = false;
	_direction = 0
	if(instance_exists(_target)){
		_direction = (x > _target.x) ? -1 : 1;
       // Se tiver no chão e bloco na frente → pula
        if (_is_on_ground && place_meeting(x + (_direction * 4), y, IDBLOCK)){
            _jump = true;
        }
		show_debug_message("INFO ENEMY : existe target : " + string(_direction));
	}
	velocity_horizontal = (_direction) * velocity;
	// Pulando
	if(_is_on_ground){
		if(_jump){
			velocity_vertical = -velocity_jump; 
		}
	}else{
		enemy_applies_gravity(); // Aplica grvidade
	}
}
// Quando a vida chega a 0
function enemy_death(){
	if (life <= 0){
		instance_destroy();	
	}
}
// aplica gravidade
function enemy_applies_gravity(){
	velocity_vertical += gravity_var;
}
// Movimentação do inimigo, aplica variaveis
function enemy_movement(){
	player_collision_horizontal();
	player_collision_vertical();
	x += velocity_horizontal;
	y += velocity_vertical;
}
// Verifica colisão horizontal
function enemy_collision_horizontal(){
	var _collision = instance_place(x + velocity_horizontal, y, IDBLOCK);
	if(_collision){
		if(velocity_horizontal > 0){
			x = _collision.bbox_left + (x - bbox_right);
		}
		if(velocity_horizontal < 0){
			x = _collision.bbox_right + (x - bbox_left);
		}
		velocity_horizontal = 0;
	}	
}
// verifica colisão vertical
function enemy_collision_vertical(){
	var _collision = instance_place(x, y + velocity_vertical, IDBLOCK);
	if(_collision){
		if(velocity_vertical > 0){
			y = _collision.bbox_top + (y - bbox_bottom);
		}
		if(velocity_vertical < 0){
			y = _collision.bbox_bottom + (y - bbox_top);
		}
		velocity_vertical = 0;
	}
}
