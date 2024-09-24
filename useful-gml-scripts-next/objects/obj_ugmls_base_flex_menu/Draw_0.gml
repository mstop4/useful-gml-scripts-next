draw_set_colour(c_white);
draw_set_font(item_font);

if (menu_draw_border) {
	// Root Node
	var _root_pos = flexpanel_node_layout_get_position(root_node, false);
	draw_rectangle(_root_pos.left, _root_pos.top, _root_pos.left + _root_pos.width, _root_pos.top + _root_pos.height, true);
}

//draw_set_halign(fa_left);
//draw_set_valign(fa_top);
//var _root_label = flexpanel_node_get_name(root_node);
//draw_text(_root_pos.left + _root_pos.paddingLeft, _root_pos.top + _root_pos.paddingTop, _root_label);