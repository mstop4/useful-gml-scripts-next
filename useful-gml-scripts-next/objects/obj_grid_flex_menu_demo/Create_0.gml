menu = instance_create_layer(32, 64, layer, obj_ugmls_grid_flex_menu, {
	player_controller: inst_control_manager.get_player(0),
	menu_width_items: grid_size,
	menu_height_items: grid_size,
	label_font: fnt_demo,
	value_font: fnt_menu_value,
	item_height: 32,
	item_width: 100,
	view_width: 4,
	view_height: 4,
	view_scroll_arrows_spr: spr_scroll_arrow,
	view_scroll_duration: 10,
	cursor_spr: spr_arrow,
	cursor_move_sfx: snd_menu_move,
	menu_draw_border: false,
	item_draw_border: false
});

for (var _i=0; _i<grid_size; _i++) {
	for (var _j=0; _j<grid_size; _j++) {
		menu.add_selectable({
			label: $"{_i + 1} x {_j + 1}",
			x: _i,
			y: _j,
			on_confirm_func: method(self, function(_menu, _item, _args) {
				show_message_async($"{_item.menu_data.x + 1} x {_item.menu_data.y + 1} = {(_item.menu_data.x + 1) * (_item.menu_data.y + 1)}");
			}),
			on_confirm_args: [],
			silent_on_confirm: false
		});
	}
}

menu.update_layout();
menu.update_view_area();