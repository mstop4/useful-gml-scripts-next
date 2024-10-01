draw_set_colour(c_white);
draw_set_alpha(1.00);

if (menu_draw_border) {
	// Root Node
	var _root_pos = flexpanel_node_layout_get_position(root_node, false);
	draw_rectangle(_root_pos.left, _root_pos.top, _root_pos.left + _root_pos.width, _root_pos.top + _root_pos.height, true);
}