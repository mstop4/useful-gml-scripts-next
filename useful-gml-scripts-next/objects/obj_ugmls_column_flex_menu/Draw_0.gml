event_inherited();
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Menu Items
for (var _i=0; _i<num_items; _i++) {
	draw_menu_item(items[_i], _i);
}