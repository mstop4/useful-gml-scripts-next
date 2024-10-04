draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(menu_alpha.v);

var _scroll_x_offset = 0;
var _scroll_y_offset = 0;

if (view_width > 0 && view_scroll_progress_x.v != 0) {
	_scroll_x_offset = (item_width + item_margin) * view_scroll_progress_x.v;
}

if (view_height > 0 && view_scroll_progress_y.v != 0) {
	_scroll_y_offset = (item_height + item_margin) * view_scroll_progress_y.v;
}

var _alignment_pos, 
	_scroll_up_pos,
	_scroll_down_pos,
	_scroll_left_pos,
	_scroll_right_pos,
	_left_right_arrow_y_offset,
	_right_arrow_x_offset,
	_up_down_arrow_x_offset,
	_down_arrow_y_offset;

if (view_width > 0 || view_height > 0) {
	_alignment_pos = flexpanel_node_layout_get_position(alignment_node, false);
}

if (menu_draw_border || view_height > 0) {
	_scroll_up_pos = flexpanel_node_layout_get_position(scroll_up_node, false);
	_scroll_down_pos = flexpanel_node_layout_get_position(scroll_down_node, false);
	_down_arrow_y_offset = view_height > 0
		? view_scroll_arrows_height + (item_height + item_margin * 2) * view_height
		: view_scroll_arrows_height + (item_height + item_margin * 2) * menu_height_items;
		
	_up_down_arrow_x_offset = view_width > 0
		? (view_scroll_arrows_height + (item_width + item_margin * 2) * view_width) / 2
		: (view_scroll_arrows_height + (item_width + item_margin * 2) * menu_width_items) / 2;
}
 
if (menu_draw_border || view_width > 0) {
	_scroll_left_pos = flexpanel_node_layout_get_position(scroll_left_node, false);
	_scroll_right_pos = flexpanel_node_layout_get_position(scroll_right_node, false);
	_right_arrow_x_offset = view_width > 0
		? view_scroll_arrows_height + (item_width + item_margin * 2) * view_width
		: view_scroll_arrows_height + (item_width + item_margin * 2) * menu_width_items;
		
	_left_right_arrow_y_offset = view_height > 0
		? (view_scroll_arrows_height + (item_height + item_margin * 2) * view_height) / 2
		: (view_scroll_arrows_height + (item_height + item_margin * 2) * menu_height_items) / 2;		
}

if (menu_draw_border) {
	// Alignment Node
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
		_alignment_pos.left + _up_down_arrow_x_offset,
		_scroll_up_pos.top,
		_alignment_pos.left + _scroll_up_pos.width + _up_down_arrow_x_offset,
		_scroll_up_pos.top + _scroll_up_pos.height,
		true
	);
	
	// Scroll Down
	draw_rectangle(
		_alignment_pos.left + _up_down_arrow_x_offset,
		_scroll_up_pos.top + _down_arrow_y_offset,
		_alignment_pos.left + _scroll_down_pos.width + _up_down_arrow_x_offset,
		_scroll_up_pos.top + _down_arrow_y_offset + _scroll_down_pos.height,
		true
	);
	
	// Scroll Left
	draw_rectangle(
		_scroll_left_pos.left,
		_alignment_pos.top + _left_right_arrow_y_offset,
		_scroll_left_pos.left + _scroll_left_pos.width,
		_alignment_pos.top + _scroll_left_pos.height + _left_right_arrow_y_offset,
		true
	);
	
	// Scroll Right
	draw_rectangle(
		_scroll_left_pos.left + _right_arrow_x_offset,
		_alignment_pos.top + _left_right_arrow_y_offset,
		_scroll_left_pos.left + _scroll_right_pos.width + _right_arrow_x_offset,
		_alignment_pos.top + _scroll_right_pos.height + _left_right_arrow_y_offset,
		true
	);
}

// Scroll Arrows
if (view_height > 0) {
	if (view_area_y.x > 0) {
		draw_sprite_ext(
			view_scroll_arrows_spr,
			0,
			_alignment_pos.left + _up_down_arrow_x_offset + _scroll_up_pos.width / 2,
			_scroll_up_pos.top + _scroll_up_pos.height / 2,			
			1, 1, 0, c_white, menu_alpha.v
		);
	}
	
	if (view_area_y.y < menu_height_items - 1) {
		draw_sprite_ext(
			view_scroll_arrows_spr,
			0,
			_alignment_pos.left + _up_down_arrow_x_offset + _scroll_down_pos.width / 2,
			_scroll_up_pos.top + _down_arrow_y_offset + _scroll_down_pos.height / 2,
			1, 1, 180, c_white, menu_alpha.v
		);
	}
}

if (view_width > 0) {
	if (view_area_x.x > 0) {
		draw_sprite_ext(
			view_scroll_arrows_spr,
			0,
			_scroll_left_pos.left + _scroll_left_pos.width / 2,
			_alignment_pos.top + _left_right_arrow_y_offset + _scroll_left_pos.height / 2,	
			1, 1, 90, c_white, menu_alpha.v
		);
	}
	
	if (view_area_x.y < menu_width_items - 1) {
		draw_sprite_ext(
			view_scroll_arrows_spr,
			0,
			_scroll_left_pos.left + _right_arrow_x_offset + _scroll_right_pos.width / 2,
			_alignment_pos.top + _left_right_arrow_y_offset + _scroll_right_pos.height / 2,
			1, 1, 270, c_white, menu_alpha.v
		);
	}
}

// Menu Items
for (var _i=view_area_x.x; _i<=view_area_x.y; _i++) {
	for (var _j=view_area_y.x; _j<=view_area_y.y; _j++) {
		if (is_undefined(items[_i][_j])) continue;
		var _base_alpha = menu_alpha.v;
		var _faded = false;
		
		if (view_width > 0) {		
			// Fade in items coming into view horizontally
			if ((view_scroll_progress_x.v < 0 && _i == view_area_x.x)  // Last element scrolling up
				|| (view_scroll_progress_x.v > 0 && _i == view_area_x.y)  // First element scrolling down 
			) {
				_base_alpha *= 1 - abs(view_scroll_progress_x.v);
				_faded = true;
			}
		}			
		
		if (view_height > 0 && !_faded) {		
			// Fade in items coming into view vertically
			if ((view_scroll_progress_y.v < 0 && _j == view_area_y.x)  // Last element scrolling up
				|| (view_scroll_progress_y.v > 0 && _j == view_area_y.y)  // First element scrolling down 
			) {
				_base_alpha *= 1 - abs(view_scroll_progress_y.v);
			}
		}	
		
		draw_menu_item(items[_i][_j], _i, _j, view_area_x.x, view_area_y.x, _scroll_x_offset, _scroll_y_offset, _base_alpha);
	}
}

// Extra Items during scroll transition
if (view_width > 0) {
	if (view_scroll_progress_x.v > 0 && view_area_x.x > 0) {
		for (var _j=view_area_y.x; _j<=view_area_y.y; _j++) {
			// Scroll left first element
			var _i = view_area_x.x - 1;
			var _item = items[_i][_j];
			var _base_alpha = abs(view_scroll_progress_x.v);
			
			draw_menu_item(_item, _i, _j, view_area_x.x, view_area_y.x, _scroll_x_offset, _scroll_y_offset, _base_alpha);
		}
	} else if (view_scroll_progress_x.v < 0 && view_area_x.y + 1 < menu_width_items) {
		// Scroll right last element
		for (var _j=view_area_y.x; _j<=view_area_y.y; _j++) {
			var _i = view_area_x.y + 1;
			var _item = items[_i][_j];
			var _base_alpha = abs(view_scroll_progress_x.v);
			
			draw_menu_item(_item, _i, _j, view_area_x.x, view_area_y.x, _scroll_x_offset, _scroll_y_offset, _base_alpha);
		}
	}
}

if (view_height > 0) {
	if (view_scroll_progress_y.v > 0 && view_area_y.x > 0) {
		for (var _i=view_area_x.x; _i<=view_area_x.y; _i++) {
			// Scroll up first element
			var _j = view_area_y.x - 1;
			var _item = items[_i][_j];
			var _base_alpha = abs(view_scroll_progress_y.v);
			
			draw_menu_item(_item, _i, _j, view_area_x.x, view_area_y.x, _scroll_x_offset, _scroll_y_offset, _base_alpha);
		}
	} else if (view_scroll_progress_y.v < 0 && view_area_y.y + 1 < menu_height_items) {
		// Scroll down last element
		for (var _i=view_area_x.x; _i<=view_area_x.y; _i++) {
			var _j = view_area_y.y + 1;
			var _item = items[_i][_j];
			var _base_alpha = abs(view_scroll_progress_y.v);
			
			draw_menu_item(_item, _i, _j, view_area_x.x, view_area_y.x, _scroll_x_offset, _scroll_y_offset, _base_alpha);
		}
	}
}

draw_set_alpha(1);