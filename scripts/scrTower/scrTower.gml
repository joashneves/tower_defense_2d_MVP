function tower_create(){
	life_max = 100;
	life = life_max;
	tower_ranged = 160;
	tower_atack_cooldown = 60;
	tower_atack_timer = 0;
}
function tower_atack(_projectile = oProjectileFrist){
	 if (tower_atack_timer > 0) {
        tower_atack_timer--;
        return;
    }
	if(instance_exists(IDENEMY)){
    // Procura inimigo dentro do alcance
	    var enemy = point_distance(x,y, IDENEMY.x, IDENEMY.y);
		show_debug_message("INFO Tower tower_atack: " + string(enemy));
	    if (enemy <= tower_ranged) {
			show_debug_message("INFO Tower :  Inimigos estao aqui");
			// Pega a altura do sprite da torre já escalado
			var spr_height = sprite_get_height(sprite_index) * image_yscale;
			var _enemy_direction = point_direction(x,y - spr_height, IDENEMY.x, IDENEMY.y);
			// Cria o projétil no topo do objeto (meio do topo)
	        // Cria projétil
	        var proj = instance_create_layer(x, y - spr_height, "Instances", _projectile);
	        proj.direction = _enemy_direction;
			proj.image_angle = _enemy_direction;
            
	        tower_atack_timer = tower_atack_cooldown; // reseta cooldown
	    
	    }
	}
}
function tower_take_damage(){
	var _take_damage = place_meeting(x, y, IDENEMYATACK)
	if(_take_damage){
		life -= IDENEMYATACK.damage;
		//instance_destroy(IDENEMYATACK);
	}
}
function tower_destroy(){
	if(life < 0){
		instance_destroy();	
	}
}
function tower_draw_ranger(){
    // Se o player estiver em cima da torre
    if (place_meeting(x, y, IDPLAYER)) {
        draw_set_alpha(0.3);
        draw_set_color(c_red);
        draw_circle(x, y, tower_ranged, false);
        draw_set_alpha(1);
    }
	draw_self()
}