event_inherited();
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _scroll_y_offset = 0;

if (view_height > 0 && view_scroll_progress_y.v != 0) {
	_scroll_y_offset = (item_height + item_margin) * -view_scroll_progress_y.v;
}

// Menu Items
for (var _i=view_area.x; _i<=view_area.y; _i++) {
	draw_menu_item(items[_i], _i, view_area.x, _scroll_y_offset);
}