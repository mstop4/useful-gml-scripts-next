fruit_list = [
	"Apples",
	"Oranges",
	"Lemons",
	"Limes",
	"Blueberries",
	"Grapes",
	"Watermelons",
	"Peaches"
];

num_fruits = array_length(fruit_list);

vegetables_list = [
	"Tomatoes",
	"Carrots",
	"Lettuce",
	"Potatoes",
	"Broccoli",
	"Onions",
	"Corn",
	"Peppers"
];

num_vegetables = array_length(vegetables_list);

praise_list = [
	"Great",
	"Amazing",
	"Fantastic",
	"Yummers",
	"Awesome"
];

set_total = method(self, function(_menu, _total_item) {
	var _total = 0;
	
	for (var _i=0; _i<_menu.num_items; _i++) {
		var _item = _menu.items[_i];
		if (_item.type == FLEX_MENU_ITEM_TYPE.SPINNER) {
			_total += _item.get_value();
		}
	}
	
	_total_item.set_value(_total);
});

reset_menu = method(self, function(_menu, _total_item) {
	for (var _i=0; _i<_menu.num_items; _i++) {
		var _item = _menu.items[_i];
		if (_item.type == FLEX_MENU_ITEM_TYPE.SPINNER) {
			_item.set_value(0);
		}
	}
	
	set_total(_menu, _total_item);
});

// Create Fruits Menu
fruits_menu = instance_create_layer(32, 128, "Instances", obj_ugmls_column_flex_menu, {
	player_controller: inst_control_manager.get_player(0),
	menu_max_width: 500,
	menu_max_height: 300,
	menu_fade_duration: 30,
	view_height: 5,
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
	keyboard_icons: [spr_keyboard_icons],
	gamepad_icons: [spr_xbox_series_gamepad_icons],
	control_icons_scale: 0.3,
	use_control_icons: true,
	menu_draw_border: false,
	item_draw_border: false
});

for (var _i=0; _i<num_fruits; _i++) {
	fruits_menu.add_spinner({
		label: fruit_list[_i],
		value_node_width: 32,
		values: create_numeric_sequence_array(0, 10, 1, true, false),
		init_index: 0,
		on_confirm_func: function(_menu, _item, _i, _value, _args) {
			var _label = _item.get_label();
			var _praise = choose_from_array(_args[0]);
			show_message_async($"You have {_value} {_label}. {_praise}!")
		},
		on_confirm_args: [praise_list],
		on_change_func: method(self, function(_menu, _item, _i, _value, _delta, _args) {
			set_total(_menu, total_fruits_item);
		}),
		on_change_args: [],
		silent_on_confirm: false,
		silent_on_change: false
	});
}

total_fruits_item = fruits_menu.add_valued_selectable({
	label: "Total",
	value_node_width: 32,
	init_value: 0,
	on_confirm_func: function(_menu, _item, _value, _args) {
		var _praise = choose_from_array(_args[0]);
		show_message_async($"You have {_value} fruits in total. {_praise}!")
	},
	on_confirm_args: [praise_list],
	on_change_func: undefined,
	on_change_args: [],
	silent_on_confirm: false,
	silent_on_change: true
});

fruits_menu.add_selectable({
	label: "Reset",
	on_confirm_func: method(self, function(_menu, _item, _args) {
		reset_menu(_menu, total_fruits_item);
	}),
	on_confirm_args: [],
	silent_on_confirm: false
});

fruits_menu.add_selectable({
	label: "Switch to Vegetable Menu",
	on_confirm_func: method(self, function(_menu, _item, _args) {
		_menu.menu_switch(vegetables_menu);
	}),
	on_confirm_args: [],
	silent_on_confirm: false
});

// Create Vegetable Menu
vegetables_menu = instance_create_layer(640, 128, "Instances", obj_ugmls_column_flex_menu, {
	player_controller: inst_control_manager.get_player(0),
	menu_max_width: 500,
	menu_max_height: 300,
	menu_fade_duration: 30,
	view_height: 5,
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
	keyboard_icons: [spr_keyboard_icons],
	gamepad_icons: [spr_xbox_series_gamepad_icons],
	control_icons_scale: 0.3,
	use_control_icons: true,
	menu_draw_border: false,
	item_draw_border: false
});

for (var _i=0; _i<num_vegetables; _i++) {
	vegetables_menu.add_spinner({
		label: vegetables_list[_i],
		value_node_width: 32,
		values: create_numeric_sequence_array(0, 10, 1, true, false),
		init_index: 0,
		on_confirm_func: function(_menu, _item, _i, _value, _args) {
			var _label = _item.get_label();
			var _praise = choose_from_array(_args[0]);
			show_message_async($"You have {_value} {_label}. {_praise}!")
		},
		on_confirm_args: [praise_list],
		on_change_func: method(self, function(_menu, _item, _i, _value, _delta, _args) {
			set_total(_menu, total_vegetables_item);
		}),
		on_change_args: [],
		silent_on_confirm: false,
		silent_on_change: false
	});
}

total_vegetables_item = vegetables_menu.add_valued_selectable({
	label: "Total",
	value_node_width: 32,
	init_value: 0,
	on_confirm_func: function(_menu, _item, _value, _args) {
		var _praise = choose_from_array(_args[0]);
		show_message_async($"You have {_value} begetables in total. {_praise}!")
	},
	on_confirm_args: [praise_list],
	on_change_func: undefined,
	on_change_args: [],
	silent_on_confirm: false,
	silent_on_change: true
});

vegetables_menu.add_selectable({
	label: "Reset",
	on_confirm_func: method(self, function(_menu, _item, _args) {
		reset_menu(_menu, total_vegetables_item);
	}),
	on_confirm_args: [],
	on_confirm_args: [],
	silent_on_confirm: false
});

vegetables_menu.add_selectable({
	label: "Switch to Fruits Menu",
	on_confirm_func: method(self, function(_menu, _item, _args) {
		_menu.menu_switch(fruits_menu);
	}),
	on_confirm_args: [],
	silent_on_confirm: false
});


fruits_menu.update_layout();
fruits_menu.update_view_area();
set_total(fruits_menu, total_fruits_item);
fruits_menu.toggle_visibility(false, true);
fruits_menu.toggle_visibility(true);

vegetables_menu.update_layout();
vegetables_menu.update_view_area();
set_total(vegetables_menu, total_vegetables_item);
vegetables_menu.toggle_visibility(false, true);