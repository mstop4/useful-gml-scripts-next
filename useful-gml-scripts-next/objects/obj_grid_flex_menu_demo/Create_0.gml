menu = instance_create_layer(32, 64, layer, obj_ugmls_grid_flex_menu, {
	menu_width_items: 4,
	menu_height_items: 4,
	item_height: 32,
	item_width: 100,
	menu_draw_border: true,
	item_draw_border: true
});

menu.update_layout();