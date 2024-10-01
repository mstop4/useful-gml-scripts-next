control_manager = instance_create_layer(0, 0, layer, obj_ugmls_control_manager);
control_manager.add_player();
my_player = control_manager.get_player(0);
reset_all_control_bindings(my_player);

menu = instance_create_layer(32, 128, "Instances", obj_ugmls_column_flex_menu, {
	player_controller: my_player,
	menu_max_width: 500,
	menu_max_height: 300,
	view_height: 2,
	view_scroll_duration: 10,
	item_height: 24,
	value_node_default_width: 64,
	label_font: fnt_demo,
	value_font: fnt_menu_value,
	cursor_spr: spr_arrow,
	cursor_move_sfx: snd_menu_move,
	cursor_confirm_sfx: snd_menu_move,
	sub_cursor_spr: spr_subarrow,
	binding_cursor_offset_x: 44,
	spinner_scroll_arrows_spr: spr_scroll_arrow,
	value_change_sfx: snd_menu_move,
	use_control_icons: true,
	keyboard_icons: [spr_keyboard_icons],
	gamepad_icons: [spr_xbox_series_gamepad_icons],
	control_icons_scale: 0.3,
	use_control_icons: true,
	menu_draw_border: false,
	item_draw_border: false
});

menu.add_selectable({
	label: "Foo",
	on_confirm_func: function(_item, _args) {
		var _label = _item.get_label();
		show_message_async($"{_label}: {_args[0]}")
	},
	on_confirm_args: [1],
	silent_on_confirm: false
});

menu.add_valued_selectable({
	label: "Bar",
	value_node_width: 32,
	init_value: 5,
	on_confirm_func: function(_item, _value, _args) {
		var _label = _item.get_label();
		show_message_async($"{_label}: Value={_value}, {_args[0]}, {_args[1]}");
		_item.set_value(_item.value + 1);
	},
	on_confirm_args: [1, 2],
	on_change_func: function(_item, _value, _args) {
		var _label = _item.get_label();
		show_debug_message($"{_label} Change: Value={_value} {_args[0]}");
	},
	on_change_args: ["a", "b"],
	silent_on_confirm: false,
	silent_on_change: true
});

menu.add_divider({
	label: "-----"
});

menu.add_spinner({
	label: "Baz",
	value_node_width: 32,
	values: [0, 1, 2, 3, 4, 5],
	init_index: 0,
	on_confirm_func: function(_item, _i, _value, _args) {
		var _label = _item.get_label();
		show_message_async($"{_label}: {_args[2]}")
	},
	on_confirm_args: [1, 2, 3],
	on_change_func: function(_item, _i, _value, _delta, _args) {
		var _label = _item.get_label();
		show_debug_message($"{_label} Change: Value={_value} {_args[0]}");
	},
	on_change_args: ["a", "b"],
	silent_on_confirm: false,
	silent_on_change: false
});

menu.add_key_config({ 
	label: "Key",
	value_node_width: 72,
	control: CONTROLS.INTERACT,
	initial_kbm_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROLS.INTERACT).values),
	initial_gamepad_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.GAMEPAD, CONTROLS.INTERACT).values),
	on_change_func: function(_item, _type, _source, _control, _index, _pressed, _args) {
		var _label = _item.get_label();
		show_debug_message($"{_label} Change: Type={_type} Source={_source} Control={_control} Index={_index} Pressed:{_pressed} {_args[0]}");
	},
	on_change_args: ["Arg?"],
	on_confirm_func: -1,
	on_confirm_args: [-1],
	silent_on_confirm: false,
	silent_on_change: false
});

menu.update_layout();
menu.update_view_area();
menu.toggle_visibility(false, true);
menu.toggle_visibility(true);