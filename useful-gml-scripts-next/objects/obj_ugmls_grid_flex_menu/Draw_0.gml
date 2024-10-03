draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(menu_alpha.v);

var _scroll_y_offset = 0;

if (view_height > 0 && view_scroll_progress_y.v != 0) {
	_scroll_y_offset = (item_height + item_margin) * view_scroll_progress_y.v;
}

var _scroll_up_pos, _scroll_down_pos, _scroll_left_pos, _scroll_right_pos, _x_offset, _y_offset;

if (menu_draw_border || view_height > 0) {
	_scroll_up_pos = flexpanel_node_layout_get_position(scroll_up_node, false);
	_scroll_down_pos = flexpanel_node_layout_get_position(scroll_down_node, false);
	_y_offset = view_height > 0
		? view_scroll_arrows_height + (item_height + item_margin * 2) * view_height
		: view_scroll_arrows_height + (item_height + item_margin * 2) * menu_height_items;
}
 
if (menu_draw_border || view_width > 0) {
	_scroll_left_pos = flexpanel_node_layout_get_position(scroll_left_node, false);
	_scroll_right_pos = flexpanel_node_layout_get_position(scroll_right_node, false);
	_x_offset = view_width > 0
		? view_scroll_arrows_height + (item_width + item_margin * 2) * view_width
		: view_scroll_arrows_height + (item_width + item_margin * 2) * menu_width_items;
}

if (menu_draw_border) {
	// Root Node
	/*var _root_pos = flexpanel_node_layout_get_position(root_node, false);
	draw_rectangle(
		_root_pos.left,
		_root_pos.top,
		_root_pos.left + _root_pos.width,
		_root_pos.top + _root_pos.height,
	true);*/
	
	// Alignment Node
	var _alignment_pos = flexpanel_node_layout_get_position(alignment_node, false);
	draw_rectangle(
		_alignment_pos.left,
		_alignment_pos.top,
		_alignment_pos.left + _alignment_pos.width,
		_alignment_pos.top + _alignment_pos.height,
	true);

	// Item List
	var _item_list_pos = flexpanel_node_layout_get_position(item_list_node, false);
	draw_rectangle(
		_item_list_pos.left,
		_item_list_pos.top,
		_item_list_pos.left + _item_list_pos.width,
		_item_list_pos.top + _item_list_pos.height,
	true);
	
	// Scroll Up
	draw_rectangle(
		_scroll_up_pos.left,
		_scroll_up_pos.top,
		_scroll_up_pos.left + _scroll_up_pos.width,
		_scroll_up_pos.top + _scroll_up_pos.height,
		true
	);
	
	// Scroll Down
	draw_rectangle(
		_scroll_down_pos.left,
		_scroll_up_pos.top + _y_offset,
		_scroll_down_pos.left + _scroll_down_pos.width,
		_scroll_up_pos.top + _y_offset + _scroll_down_pos.height,
		true
	);
	
	// Scroll Left
	draw_rectangle(
		_scroll_left_pos.left,
		_scroll_left_pos.top,
		_scroll_left_pos.left + _scroll_left_pos.width,
		_scroll_left_pos.top + _scroll_left_pos.height,
		true
	);
	
	// Scroll Right
	draw_rectangle(
		_scroll_left_pos.left + _x_offset,
		_scroll_right_pos.top,
		_scroll_left_pos.left + _scroll_right_pos.width + _x_offset,
		_scroll_right_pos.top + _scroll_right_pos.height,
		true
	);
	
	for (var _i=0; _i<menu_height_items; _i++) {
		var _row_pos = flexpanel_node_layout_get_position(row_nodes[_i], false);
		draw_rectangle(
			_row_pos.left,
			_row_pos.top,
			_row_pos.left + _row_pos.width,
			_row_pos.top + _row_pos.height,
			true
		);
	}
}

// Scroll Arrows
/*if (view_height > 0) {
	if (view_area.x > 0) {
		draw_sprite_ext(
			view_scroll_arrows_spr,
			0,
			_scroll_up_pos.left + _scroll_up_pos.width / 2,
			_scroll_up_pos.top + _scroll_down_pos.height / 2,
			1, 1, 0, c_white, menu_alpha.v
		);
	}
	
	if (view_area.y < num_items - 1) {
		draw_sprite_ext(
			view_scroll_arrows_spr,
			0,
			_scroll_down_pos.left + _scroll_down_pos.width / 2,
			_scroll_up_pos.top + _y_offset + _scroll_down_pos.height / 2,
			1, 1, 180, c_white, menu_alpha.v
		);
	}
}*/

// Menu Items

for (var _i=0; _i<menu_height_items; _i++) {
	for (var _j=0; _j<menu_width_items; _j++) {
		if (is_undefined(items[_j][_i])) continue;
		
		var _base_alpha = menu_alpha.v;
		draw_menu_item(items[_j][_i], _j, _i, 0, 0, 0, 0, _base_alpha);
	}
}

/*for (var _i=view_area.x; _i<=view_area.y; _i++) {
	var _base_alpha = menu_alpha.v;
	if (view_height > 0) {		
		// Fade in items coming into view
		if ((view_scroll_progress_y.v < 0 && _i == view_area.x)  // Last element scrolling up
			|| (view_scroll_progress_y.v > 0 && _i == view_area.y)  // First element scrolling down 
		) {
			_base_alpha *= 1 - abs(view_scroll_progress_y.v);
		}
	}	
	
	draw_menu_item(items[_i], _i, view_area.x, _scroll_y_offset, _base_alpha);
}*/

// Extra Items during scroll transition
/*if (view_height > 0) {
	if (view_scroll_progress_y.v > 0 && view_area.x > 0) {
		// Scroll up first element
		var _index = view_area.x - 1;
		var _item = items[_index];
		var _base_alpha = abs(view_scroll_progress_y.v);
			
		draw_menu_item(_item, _index, view_area.x, _scroll_y_offset, _base_alpha);
	} else if (view_scroll_progress_y.v < 0 && view_area.y + 1 < num_items) {
		// Scroll down last element
		var _index = view_area.y + 1;
		var _item = items[_index];
		var _base_alpha = abs(view_scroll_progress_y.v);
			
		draw_menu_item(_item, _index, view_area.x, _scroll_y_offset, _base_alpha);
	}
}*/

draw_set_alpha(1);