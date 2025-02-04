rooms = [
	room_colours_demo,
	room_control_manager_demo,
	room_data_structures_demo,
	room_debugging_demo,
	room_drawing_demo,
	room_compromise_scaler_demo,
	room_easing_demo,
	room_laser_demo,
	room_input_demo,
	room_math_demo,
	room_delta_timeline_plus_demo,
	room_column_menu_demo,
	room_grid_menu_demo,
	room_nested_menu_demo,
	room_key_config_menu_demo,
	room_column_flex_menu_demo,
	room_signal_manager_demo,
	room_strings_demo,
	room_web_demo,
	room_system_info
];
num_rooms = array_length(rooms);

room_names = [
	"Colours Demo",
	"Control Manager",
	"Data Structures",
	"Debugging",
	"Drawing",
	"Compromise Scaler",
	"Easings",
	"Geometry",
	"Input",
	"Math",
	"Delta Timeline Plus",
	"Column Menu",
	"Grid Menu",
	"Nested Menu",
	"Control Config Menu",
	"Column Flex Menu",
	"Signal Manager",
	"Strings",
	"Web",
	"System Info"
];

go_to_demo = method(self, function(_menu, _item, _args) {
	io_clear();
	inst_control_manager.get_player(0).clear_all_input();
	room_goto(_args[0]);
});

menu = instance_create_layer(32, 56, layer, obj_ugmls_column_flex_menu, {
	player_controller: inst_control_manager.get_player(0),
	menu_max_width: 200,
	menu_max_height: "100%",
	view_height: 16,
	view_scroll_duration: 5,
	view_scroll_arrows_spr: spr_scroll_arrow,
	item_height: 28,
	label_font: fnt_demo,
	value_font: fnt_menu_value,
	cursor_spr: spr_arrow,
	cursor_move_sfx: snd_menu_move,
	cursor_confirm_sfx: snd_menu_move,
	sub_cursor_spr: spr_subarrow,
	spinner_scroll_arrows_spr: spr_scroll_arrow,
	value_change_sfx: snd_menu_move,
	keyboard_icons: [spr_keyboard_icons],
	gamepad_icons: [spr_xbox_series_gamepad_icons],
});

for (var _i=0; _i<num_rooms; _i++) {
	menu.add_selectable({
		label: room_names[_i],
		on_confirm_func: self.go_to_demo,
		on_confirm_args: [ rooms[_i] ],
		silent_on_confirm: false
	});
}

menu.update_layout();
menu.update_view_area();

/*
menu = instance_create_layer(32, 64, layer, obj_ugmls_column_menu);
menu.column_menu_init({
	player_controller: inst_control_manager.get_player(0),
	label_font: fnt_demo,
	value_font: fnt_menu_value,
	view_height: 16,
	cursor_spr: spr_arrow, 
	cursor_move_sfx: snd_menu_move,
	cursor_change_sfx: -1,
	cursor_confirm_sfx: -1,
	use_control_icons: false,
	keyboard_icons: [],
	gamepad_icons: [],
	control_icons_scale: 1,
});
menu.line_spacing = 8;

for (var _i=0; _i<num_rooms; _i++) {
	menu.add_selectable({
		label: room_names[_i],
		on_confirm_func: self.go_to_demo,
		on_confirm_args: [ rooms[_i] ],
		silent_on_confirm: false
	});
}
*/