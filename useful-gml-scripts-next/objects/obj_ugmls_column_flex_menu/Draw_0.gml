event_inherited();
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _scroll_y_offset = 0;

if (view_height > 0 && view_scroll_progress_y.v != 0) {
	_scroll_y_offset = (item_height + item_margin) * view_scroll_progress_y.v;
}

// Menu Items
for (var _i=view_area.x; _i<=view_area.y; _i++) {
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
}

// Extra Items during scroll transition
if (view_height > 0) {
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
}

draw_set_alpha(1);