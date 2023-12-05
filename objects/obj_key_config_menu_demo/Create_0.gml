reset_bindings = method(id, function() {
	io_clear();
	self.my_player.clear_all_input();
	inst_persistent_controller.reset_all_control_bindings();
	var _num_items = array_length(self.menu.items);
		
	for (var _i = 0; _i < _num_items; _i++) {
		var _item = self.menu.items[_i];
		if (_item.type != "keyconfig") return;

		_item.kbm_bindings = duplicate_array(my_player.get_bindings(CONTROL_TYPE.KEYBOARD_AND_MOUSE, _item.control).values);
		_item.gamepad_bindings = duplicate_array(my_player.get_bindings(CONTROL_TYPE.GAMEPAD,  _item.control).values);
	}
});

// Set up Control Manager
control_labels[CONTROLS.UP] = "Up";
control_labels[CONTROLS.DOWN] = "Down";
control_labels[CONTROLS.LEFT] = "Left";
control_labels[CONTROLS.RIGHT] = "Right";

num_controls = 4;
my_player = inst_control_manager.get_player(0);

current_gamepad_index = inst_control_manager.is_on_steam_deck()
	? inst_control_manager.get_steam_deck_gamepad_index()
	: 0;
my_player.set_gamepad_slot(current_gamepad_index);

// Set key config menu
menu = instance_create_layer(32, 96, layer, obj_ugmls_column_menu);
menu.column_menu_init({
	player_controller: my_player,
	label_font: fnt_demo,
	value_font: fnt_menu_value,
	view_height: 0,
	cursor_spr: spr_arrow, 
	cursor_move_sfx: snd_menu_move,
	cursor_change_sfx: snd_menu_move,
	cursor_confirm_sfx: -1,
	use_control_icons: true,
	keyboard_icons: [spr_keyboard_icons],
	gamepad_icons: [spr_xbox_series_gamepad_icons],
	control_icons_scale: 0.3
});

for (var _i=CONTROLS.UP; _i<=CONTROLS.RIGHT; _i++) {
	menu.add_key_config({ 
		label: control_labels[_i],
		control: _i,
		initial_kbm_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.KEYBOARD_AND_MOUSE, _i).values),
		initial_gamepad_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.GAMEPAD, _i).values),
		on_change_func: -1,
		on_change_args: [-1],
		on_confirm_func: -1,
		on_confirm_args: [-1],
		silent_on_confirm: false,
		silent_on_change: false
	});
}

var _cancel_rebinding = menu.add_key_config({ 
	label: "Cancel Rebinding",
	control: CONTROLS.MENU_CANCEL,
	initial_kbm_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROLS.MENU_CANCEL).values),
	initial_gamepad_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.GAMEPAD, CONTROLS.MENU_CANCEL).values),
	on_change_func: -1,
	on_change_args: [-1],
	on_confirm_func: -1,
	on_confirm_args: [-1],
	silent_on_confirm: false,
	silent_on_change: false
});

var _remove_binding = menu.add_key_config({ 
	label: "Remove Binding",
	control: CONTROLS.DELETE_BINDING,
	initial_kbm_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.KEYBOARD_AND_MOUSE, CONTROLS.DELETE_BINDING).values),
	initial_gamepad_bindings: duplicate_array(my_player.get_bindings(CONTROL_TYPE.GAMEPAD, CONTROLS.DELETE_BINDING).values),
	on_change_func: -1,
	on_change_args: [-1],
	on_confirm_func: -1,
	on_confirm_args: [-1],
	silent_on_confirm: false,
	silent_on_change: false
});

menu.add_selectable({
	label: "Reset All Bindings",
	on_confirm_func: self.reset_bindings,
	on_confirm_args: [],
	silent_on_confirm: false
});

_cancel_rebinding.set_binding_locked(CONTROL_TYPE.KEYBOARD_AND_MOUSE, 0, true);
_cancel_rebinding.set_binding_locked(CONTROL_TYPE.GAMEPAD, 0, true);
_remove_binding.set_binding_locked(CONTROL_TYPE.KEYBOARD_AND_MOUSE, 0, true);
_remove_binding.set_binding_locked(CONTROL_TYPE.GAMEPAD, 0, true);

menu.label_width = 192;
menu.binding_spacing = 160;