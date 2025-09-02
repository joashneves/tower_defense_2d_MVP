// Escolhe borda (0 = cima, 1 = baixo, 2 = esquerda, 3 = direita)
var side = irandom(3);

var _x, _y;

// Sorteia posição conforme a borda
switch (side) {
    case 0: // Topo
        _x = irandom(room_width);
        _y = 0;
        break;
    case 1: // Base
        _x = irandom(room_width);
        _y = room_height;
        break;
    case 2: // Esquerda
        _x = 0;
        _y = irandom(room_height);
        break;
    case 3: // Direita
        _x = room_width;
        _y = irandom(room_height);
        break;
}

// Agora procura bloco nessa posição (em baixo do inimigo)
var blk = instance_position(_x, _y, oBlock);

if (blk != noone) {
    // Cria o inimigo logo acima do bloco
    var enemy = instance_create_layer(blk.x, blk.bbox_top - 32/2, "Instances", oEnemyCommon);
	 show_debug_message("Objeto criado!");
} else {
    // Se não achou bloco, pode tentar de novo ou ignorar
    show_debug_message("Nenhum bloco encontrado nessa posição.");
}

alarm[0] = 12;

