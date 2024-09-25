my_player = inst_control_manager.get_player(0);

menu = instance_create_layer(32, 64, "Instances", obj_ugmls_column_flex_menu, {
	player_controller: my_player,
	menu_max_width: "25%",
	item_height: 32,
	item_font: fnt_demo,
	cursor_spr: spr_arrow,
	cursor_move_sfx: snd_menu_move,
	cursor_confirm_sfx: snd_menu_move,
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
	on_confirm_func: function(_item, _args) {
		var _label = _item.get_label();
		var _value = _item.value;
		show_message_async($"{_label}: Value={_value}, {_args[0]}, {_args[1]}");
		_item.set_value(_item.value + 1);
	},
	on_confirm_args: [1, 2],
	on_change_func: function(_item, _args) {
		var _label = _item.get_label();
		var _value = _item.value;
		show_debug_message($"{_label} Change: Value={_value} {_args[0]}");
	},
	on_change_args: ["a", "b"],
	silent_on_confirm: false,
	silent_on_change: true
});

menu.add_divider({
	label: "-----"
});

menu.add_selectable({
	label: "Baz",
	on_confirm_func: function(_item, _args) {
		var _label = _item.get_label();
		show_message_async($"{_label}: {_args[2]}")
	},
	on_confirm_args: [1, 2, 3],
	silent_on_confirm: false
});
menu.update_layout();