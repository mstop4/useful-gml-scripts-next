my_player = inst_control_manager.get_player(0);

menu = instance_create_layer(32, 64, "Instances", obj_ugmls_column_flex_menu, {
	player_controller: my_player,
	menu_max_width: "25%",
	item_height: 32,
	item_font: fnt_demo,
	cursor_spr: spr_arrow,
	cursor_move_sfx: snd_menu_move,
	cursor_confirm_sfx: snd_menu_move,
	spinner_scroll_arrows_spr: spr_scroll_arrow,
	value_change_sfx: snd_menu_move
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
menu.update_layout();