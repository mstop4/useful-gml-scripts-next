event_inherited();
var _x_offset = 0;
var _y_offset = 0;

if (view_width > 0 && view_scroll_progress_x.v != 0) {
	_x_offset = (cursor_padding + column_width) * -view_scroll_progress_x.v;
}

if (view_height > 0 && view_scroll_progress_y.v != 0) {
	_y_offset = (item_height + line_spacing) * -view_scroll_progress_y.v;
}

var _x, _y, _item;

for (var _i=view_area.left; _i<=view_area.right; _i++) {
	_x = x + cursor_padding * (_i-view_area.left+1) + column_width * (_i-view_area.left);
	_y = y;

	for (var _j=view_area.top; _j<=view_area.bottom; _j++) {
		_item = items[# _i, _j];
		
		if (is_struct(_item)) {
			if (view_width > 0) {
				if (view_scroll_progress_x.v < 0 && _i == view_area.right) {
					// Scroll left last element
					draw_set_alpha(1-abs(view_scroll_progress_x.v));
				} else if (view_scroll_progress_x.v > 0 && _i == view_area.left) {
					// Scroll right first element
					draw_set_alpha(1-abs(view_scroll_progress_x.v));
				} else {
				draw_set_alpha(menu_alpha.v);
				}
			}
		
			if (view_height > 0) {
				if (view_scroll_progress_y.v < 0 && _j == view_area.bottom) {
					// Scroll up last element
					draw_set_alpha(1-abs(view_scroll_progress_y.v));
				} else if (view_scroll_progress_y.v > 0 && _j == view_area.top) {
					// Scroll down first element
					draw_set_alpha(1-abs(view_scroll_progress_y.v));
				} else {
					draw_set_alpha(menu_alpha.v);
				}
			}
		
			var _is_focused = (pos.x == _i) && (pos.y == _j);
			self.draw_menu_item(_item, _x + _x_offset, _y + _y_offset, _is_focused);
		}
		
		if (view_width > 0 && _i == view_area.left) {
			if (view_scroll_progress_x.v < 0 && view_area.left > 0) {
				// Scroll left first element
				_item = items[# view_area.left - 1, _j];
				if (is_struct(_item)) {
					draw_set_alpha(abs(view_scroll_progress_x.v));
					
					var _is_focused = (pos.x == view_area.left - 1) && (pos.y == _j);
					self.draw_menu_item(_item, x - column_width + _x_offset, _y + _y_offset, _is_focused);
				}
			} else if (view_scroll_progress_x.v > 0 && view_area.right + 1 < items_width) {
				// Scroll right last element
				_item = items[# view_area.right + 1, _j];
				if (is_struct(_item)) {
					draw_set_alpha(abs(view_scroll_progress_x.v));
					
					var _is_focused = (pos.x == view_area.right + 1) && (pos.y == _j);
					self.draw_menu_item(_item, _x + (column_width + cursor_padding)*2  + _x_offset, _y + _y_offset, _is_focused);
				}
			}
			// Feather restore GM1010
		}
		
		_y += item_height + line_spacing;
	}
	
	if (view_height > 0) {
		if (view_scroll_progress_y.v < 0 && view_area.top > 0) {
			// Scroll up first element
			_item = items[# _i, view_area.top - 1];
			if (is_struct(_item)) {
				draw_set_alpha(abs(view_scroll_progress_y.v));
				
				var _is_focused = (pos.x == _i) && (pos.y == view_area.top - 1);
				self.draw_menu_item(_item, _x + _x_offset, y - (item_height + line_spacing) + _y_offset, _is_focused);
			}
		} else if (view_scroll_progress_y.v > 0 && view_area.bottom + 1 < items_height) {
			// Scroll down last element
			_item = items[# _i, view_area.bottom + 1];
			if (is_struct(_item)) {
				draw_set_alpha(abs(view_scroll_progress_y.v));
				
				var _is_focused = (pos.x == _i) && (pos.y == view_area.bottom + 1);
				self.draw_menu_item(_item, _x + _x_offset, _y + _y_offset, _is_focused);
			}
		}
	}
}

draw_set_alpha(menu_alpha.v);

if (enabled) {
	draw_sprite(cursor_spr, 0,
		x + (cursor_padding + column_width) * (pos.x - view_area.left),
		y + (item_height + line_spacing) * (pos.y - view_area.top) + item_height / 2
	);
	
	if (view_height >= 1) {
		if (view_area.top > 0) {
			draw_sprite(view_scroll_arrows_spr, 0, x + view_scroll_arrows_x, y - view_scroll_arrows_margin);
		}

		if (view_area.bottom < items_height - 1) {
			draw_sprite_ext(view_scroll_arrows_spr, 0, x + view_scroll_arrows_x, _y + view_scroll_arrows_margin, 1, -1, 0, c_white, 1);
		}
	}
	if (view_width >= 1) {
		if (view_area.left > 0){
			draw_sprite_ext(view_scroll_arrows_spr, 0, x - view_scroll_arrows_margin, y + view_scroll_arrows_y, 1, 1, 90, c_white, 1);
		}

		if (view_area.right < items_width - 1) {
			draw_sprite_ext(view_scroll_arrows_spr, 0, _x + view_scroll_arrows_margin + cursor_padding, y + view_scroll_arrows_y, 1, 1, 270, c_white, 1);
		}
	}
}