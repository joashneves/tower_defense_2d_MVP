function player_create(){
	velocity_horizontal = 0;
	velocity_vertical = 0;
	velocity = 2;
	gravity_var = 0.3;
	velocity_jump = 9;
}
// controla o player
function player_controller(){
	var _is_jump_true = place_meeting(x, y + 1, IDBLOCK);
	var _left, _rigth, _jump;
	_left = keyboard_check(ord("A"));
	_rigth = keyboard_check(ord("D"));
	_jump = keyboard_check_pressed(ord("W"));
	velocity_horizontal = (_rigth - _left) * velocity;
	// Pulando
	if(_is_jump_true){
		if(_jump){
			velocity_vertical = -velocity_jump; 
		}
	}else{
		player_applies_gravity(); // Aplica grvidade
	}
}
// aplica gravidade
function player_applies_gravity(){
	velocity_vertical += gravity_var;
}
// Movimentação do player, aplica variaveis
function player_movement(){
	player_collision_horizontal();
	player_collision_vertical();
	x += velocity_horizontal;
	y += velocity_vertical;
}
// Verifica colisão horizontal
function player_collision_horizontal(){
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
function player_collision_vertical(){
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
