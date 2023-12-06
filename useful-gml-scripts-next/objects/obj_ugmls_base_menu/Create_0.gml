/// @desc						Initializes base menu.
/// @param {Struct} _config
///								 - {Id.Instance} player_controller
///								 - {Font} font
///								 - {Sprite} cursor_spr
///								 - {boolean} use_control_icons
///								 - {Array<Asset.GMSprite>} keyboard_icons
///								 - {Array<Asset.GMSprite>} gamepad_icons
///								 - {number} control_icons_scale
menu_base_init = method(self, function(_config) {
	player_controller = _config.player_controller;
	control_state = new MenuControlState(_config.player_controller);
	var _old_font = draw_get_font();
	draw_set_font(_config.label_font);
	item_height = string_height("Ij");
	cursor_width = sprite_get_width(_config.cursor_spr);
	cursor_height = sprite_get_height(_config.cursor_spr);
	draw_set_font(_old_font);
	use_control_icons = _config.use_control_icons;
	keyboard_icons = _config.keyboard_icons;
	gamepad_icons = _config.gamepad_icons;
	keyboard_icons_index = 0;
	gamepad_icons_index = 0;
	control_icons_scale = _config.control_icons_scale;
	keyboard_icons_width = array_map(keyboard_icons, function(_sprite) {
		return sprite_get_width(_sprite);
	});
	gamepad_icons_width = array_map(gamepad_icons, function(_sprite) {
		return sprite_get_width(_sprite);
	});
	keyboard_icons_half_height = array_map(keyboard_icons, function(_sprite) {
		return sprite_get_height(_sprite) / 2;
	});
	gamepad_icons_half_height = array_map(gamepad_icons, function(_sprite) {
		return sprite_get_height(_sprite) / 2;
	});
});

start_scroll_up = method(self, function() {
	view_scroll_progress_y.v = 1;
	view_scroll_progress_y.d = -1/view_scroll_duration;
});

start_scroll_down = method(self, function() {
	view_scroll_progress_y.v = -1;
	view_scroll_progress_y.d = 1/view_scroll_duration;
});

/// @param {Struct.MenuSelectable} _item 
handle_selectable_confirm = method(self, function(_item) {
	if (!_item.enabled) return;
	if (is_callable(_item.on_confirm_func)) {
		_item.on_confirm_func(_item.on_confirm_args);
	}

	if (!_item.silent_on_confirm && audio_exists(cursor_confirm_sfx)) {
		audio_play_sound(cursor_confirm_sfx, 1, false);
	}
});

/// @param {Struct.MenuValuedSelectable} _item 
handle_valued_selectable_confirm = method(self, function(_item) {
	if (!_item.enabled) return;
	if (is_callable(_item.on_confirm_func)) {
		_item.on_confirm_func(_item, _item.on_confirm_args);
	}

	if (!_item.silent_on_confirm && audio_exists(cursor_confirm_sfx)) {
		audio_play_sound(cursor_confirm_sfx, 1, false);
	}
});

/// @param {Struct.MenuSpinner} _item 
handle_spinner_confirm = method(self, function(_item) {
	if (!_item.enabled) return;
	if (is_callable(_item.on_confirm_func)) {
		_item.on_confirm_func(_item.cur_index, _item.values[_item.cur_index], _item.on_confirm_args);
	}

	if (!_item.silent_on_confirm && audio_exists(cursor_confirm_sfx)) {
		audio_play_sound(cursor_confirm_sfx, 1, false);
	}
});

/// @param {Struct.MenuSpinner} _item
/// @param {real}								_delta -1 or 1
handle_spinner_change = method(self, function(_item, _delta) {
	if (!_item.enabled) return;
	var _num_values = array_length(_item.values);
	_item.cur_index = wrap(_item.cur_index+_delta, 0, _num_values);
		
	if (is_callable(_item.on_change_func)) {
		_item.on_change_func(
			_item.cur_index,
			_item.values[_item.cur_index],
			_delta,
			_item.on_change_args
		);
	}
		
	if (!_item.silent_on_change && audio_exists(cursor_change_sfx)) {
		audio_play_sound(cursor_change_sfx, 1, false);
	}
});

/// @param {Struct.MenuKeyConfig} _item
/// @param {real}									_delta
handle_key_config_select = method(self, function(_item, _delta) {
	if (!_item.enabled) return;
	var _num_values = KEYBOARD_MAX_BINDINGS_PER_CONTROL + GAMEPAD_MAX_BINDINGS_PER_CONTROL;
	var _last_pressed = control_state.control_any_pressed();
	var _binding_info;
	var _original_value = _item.current_binding_index;

	do {
		_item.current_binding_index = wrap(_item.current_binding_index+_delta, 0, _num_values);
		_binding_info = _item.get_binding_info();
	} until (_item.current_binding_index == _original_value || _last_pressed.control_type == _binding_info.control_type)

	if (_item.current_binding_index != _original_value && !_item.silent_on_change && audio_exists(cursor_change_sfx)) {
		audio_play_sound(cursor_change_sfx, 1, false);
	}
});

/// @param {Struct.MenuKeyConfig} _item
handle_key_config_confirm = method(self, function(_item) {
	if (!_item.enabled) return;
	var _last_pressed = control_state.control_any_pressed();	
	
	if (discovery_mode == MENU_DISCOVERY_MODE.NONE) {
		// Not selected
		if (_last_pressed.control_type == CONTROL_TYPE.GAMEPAD) {
			_item.current_binding_index = KEYBOARD_MAX_BINDINGS_PER_CONTROL;
		} else {
			_item.current_binding_index = 0;
		}
		discovery_mode = MENU_DISCOVERY_MODE.SELECTING;
		active_key_config = _item;
	} else if (discovery_mode == MENU_DISCOVERY_MODE.SELECTING) {
		// Selecting
		var _binding_info = _item.get_binding_info();
		
		if (_last_pressed.control_type != _binding_info.control_type) return;		
		if (_binding_info.binding_locked) return;

		discovery_mode = MENU_DISCOVERY_MODE.DISCOVERING;
		_item.discovery_binding_info = _binding_info;
		io_clear();
	}
});

/// @param {Struct.MenuKeyConfig} _item
handle_key_config_cancel = method(self, function(_item) {
	if (!_item.enabled) return;
	if (discovery_mode == MENU_DISCOVERY_MODE.SELECTING) {
		discovery_mode = MENU_DISCOVERY_MODE.NONE;
		active_key_config = -1;		
	}
});

/// @param {Struct.MenuKeyConfig} _item
handle_key_config_delete = method(self, function(_item) {
	if (!_item.enabled) return;
	var _binding_info = _item.get_binding_info();
	if (_binding_info.binding_locked) return;
	
	var _control_index = _binding_info.control_index;
	var _control_type = _binding_info.control_type;
	var _binding_key = "";

	if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
		_binding_key = "kbm_bindings";
	} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
		_binding_key = "gamepad_bindings";
	} else {
		return;
	}
	
	_item[$ _binding_key][_control_index] = -1;
	player_controller.remove_binding(_control_type, _item.control, _control_index);
	discovery_mode = MENU_DISCOVERY_MODE.NONE;
	if (active_key_config) {
		active_key_config.discovery_binding_info = false;
	}
	active_key_config = -1;
});

/// @param {Struct.MenuKeyConfig} _item
handle_key_config_discovery = method(self, function(_item) {
	if (!_item.enabled) return;
	if (control_state.pressed_state[MENU_CONTROLS.CANCEL]) {
		discovery_mode = MENU_DISCOVERY_MODE.SELECTING;
		active_key_config.discovery_binding_info = false;
		return;
	}

	var _control_type = active_key_config.discovery_binding_info.control_type;
	var _last_pressed = control_state.control_any_pressed();		
	
	if (_last_pressed != -1 && _last_pressed.control_type == _control_type) {
		var _control_index = active_key_config.discovery_binding_info.control_index;
		var _binding_key = "";		
		
		if (_control_type == CONTROL_TYPE.KEYBOARD_AND_MOUSE) {
			if (array_find(global.ugmls_disallowed_keyboard_controls, _last_pressed.control_pressed) != -1) return;
			_binding_key = "kbm_bindings";
		} else if (_control_type == CONTROL_TYPE.GAMEPAD) {
			if (array_find(global.ugmls_disallowed_gamepad_controls, _last_pressed.control_pressed) != -1) return;
			_binding_key = "gamepad_bindings";
		} else {
			return;
		}		
		
		active_key_config[$ _binding_key][_control_index] = _last_pressed.control_pressed;
		player_controller.set_binding(_control_type, _last_pressed.control_source, active_key_config.control, _control_index, _last_pressed.control_pressed);
		discovery_mode = MENU_DISCOVERY_MODE.NONE;
		active_key_config.discovery_binding_info = false;

		if (is_callable(active_key_config.on_change_func)) {
			active_key_config.on_change_func(_control_type, _last_pressed.control_source, active_key_config.control, _control_index, _last_pressed.control_pressed, active_key_config.on_change_args);
		}

		active_key_config = -1;
		io_clear();
	}
});

/// @param {Struct.MenuItem} _item
/// @param {Real} _x
/// @param {Real} _y
/// @param {Bool} _is_focused
draw_menu_item = method(self, function(_item, _x, _y, _is_focused = false) {
	var _type = _item.type;
	if (_item.enabled) draw_set_colour(c_white);
	else draw_set_colour(c_gray);

	var _item_value;

	switch (_type) {
		case "item":
		case "selectable":
			draw_set_font(menu_label_font);
			draw_text(_x, _y, _item.label);
			break;
			
		case "valuedSelectable":
			draw_set_font(menu_label_font);
			draw_text(_x, _y, _item.label);
			draw_set_font(menu_value_font);
			draw_text(_x + label_width, _y + spinner_value_text_y_offset, _item.get_value());
			break;
			
		case "spinner":
			_item_value = _item.get_value();
			draw_set_font(menu_label_font);
			draw_text(_x, _y, _item.label);
			draw_set_font(menu_value_font);
			draw_text(_x + label_width, _y + spinner_value_text_y_offset, _item_value);
		
			if (_is_focused) {
				var _alpha = draw_get_alpha();
				var _text_width = string_width(_item_value);
			
				draw_sprite_ext(
					spinner_scroll_arrows_spr,
					0,
					_x + label_width - spinner_scroll_arrows_margin,
					_y + spinner_value_text_y_offset + spinner_scroll_arrows_y + item_height / 2,
					1, 1, 90, c_white, _alpha
				);
			
				draw_sprite_ext(
					spinner_scroll_arrows_spr,
					0,
					_x + label_width + spinner_scroll_arrows_margin + _text_width,
					_y + spinner_value_text_y_offset + spinner_scroll_arrows_y + item_height / 2,
					1, 1, 270, c_white, _alpha
				);
			}
			break;
			
		case "keyconfig":
			draw_set_font(menu_label_font);
			draw_text(_x, _y, _item.label);
			var _cur_x = _x + label_width;
			var _cur_binding_index = 0;
			draw_set_font(menu_value_font);
		
			// Draw keyboard bindings
			for (var _i=0; _i<KEYBOARD_MAX_BINDINGS_PER_CONTROL; _i++) {
				if (use_control_icons) {
					var _item_icon_index = _item.get_icon_index(CONTROL_TYPE.KEYBOARD_AND_MOUSE, _i);
					draw_sprite_ext(keyboard_icons[keyboard_icons_index], _item_icon_index, _cur_x, _y + control_icons_y_offset * control_icons_scale, control_icons_scale, control_icons_scale, 0, c_white, menu_alpha.v);
					if (_item.locked_kbm_bindings[_i]) {
						draw_sprite_ext(lock_sprite, 0,
							_cur_x + keyboard_icons_width[keyboard_icons_index] * control_icons_scale + 24,
							_y + (control_icons_y_offset + keyboard_icons_half_height[keyboard_icons_index]) * control_icons_scale,
							control_icons_scale, control_icons_scale, 0, c_white, menu_alpha.v
						);
					}
				} else {
					_item_value = _item.get_text_value(CONTROL_TYPE.KEYBOARD_AND_MOUSE, _i);
					if (_item.locked_kbm_bindings[_i]) {
						draw_set_colour(c_gray);
					} else {
						if (_item.enabled) draw_set_colour(c_white);
						else draw_set_colour(c_gray);
					}
					draw_text(_cur_x, _y, _item_value);
				}
				if (discovery_mode != MENU_DISCOVERY_MODE.NONE
					&& active_key_config == _item
					&& _cur_binding_index == _item.current_binding_index) {
					draw_sprite(sub_cursor_spr, 0, _cur_x - cursor_padding, _y + item_height / 2);
				}
			
				_cur_x += binding_spacing;
				_cur_binding_index++;
			}
		
			_cur_x += binding_type_spacing;
		
			// Draw gamepad bindings
			for (var _i=0; _i<GAMEPAD_MAX_BINDINGS_PER_CONTROL; _i++) {
				if (use_control_icons) {
					var _item_icon_index = _item.get_icon_index(CONTROL_TYPE.GAMEPAD, _i);
					draw_sprite_ext(gamepad_icons[gamepad_icons_index], _item_icon_index, _cur_x, _y + control_icons_y_offset * control_icons_scale, control_icons_scale, control_icons_scale, 0, c_white, menu_alpha.v);
					if (_item.locked_gamepad_bindings[_i]) {
							draw_sprite_ext(lock_sprite, 0,
							_cur_x + gamepad_icons_width[gamepad_icons_index] * control_icons_scale + 24,
							_y + (control_icons_y_offset + gamepad_icons_half_height[gamepad_icons_index]) * control_icons_scale,
							control_icons_scale, control_icons_scale, 0, c_white, menu_alpha.v
						);
					}
				} else {
					_item_value = _item.get_text_value(CONTROL_TYPE.GAMEPAD, _i);
					if (_item.locked_gamepad_bindings[_i]) {
						draw_set_colour(c_gray);
					} else {
						if (_item.enabled) draw_set_colour(c_white);
						else draw_set_colour(c_gray);
					}			
			
					draw_text(_cur_x, _y, _item_value);
				}

				if (discovery_mode != MENU_DISCOVERY_MODE.NONE
					&& active_key_config == _item
					&& _cur_binding_index == _item.current_binding_index) {
					draw_sprite(sub_cursor_spr, 0, _cur_x - cursor_padding, _y + item_height / 2);
				}
	
				_cur_x += binding_spacing;
				_cur_binding_index++;
			}
			break;
		
		default:
			draw_text(_x, _y, _item.label);
	}
});

/// @param {Id.Instance} _next_menu
/// @param {Function}		 _on_switch_cb
/// @param {Array<any>}  _on_switch_cb_args
menu_switch = method(self, function(_next_menu, _on_switch_cb, _on_switch_cb_args) {
	menu_fade_out(_next_menu, _on_switch_cb, _on_switch_cb_args);
});

/// @param {Id.Instance} _next_menu
/// @param {Function}		 _on_end_cb
/// @param {Array<any>}  _on_end_cb_args
menu_fade_out = method(self, function(_next_menu, _on_end_cb, _on_end_cb_args) {
	enabled = false;
	next_menu = _next_menu;
	on_fade_out_end = _on_end_cb;
	on_fade_out_end_args = _on_end_cb_args;
	menu_alpha.v = 1;
	menu_alpha.d = -1/menu_fade_time;
	alarm[11] = menu_fade_time;
});

menu_fade_in = method(self, function() {
	enabled = false;
	visible = true;
	menu_alpha.v = 0;
	menu_alpha.d = 1/menu_fade_time;
	alarm[10] = menu_fade_time;
});

enabled = true;

control_state = noone;
player_controller = noone;

item_height = 1;
cursor_width = 1;
cursor_height = 1;
use_control_icons = false;
keyboard_icons = [];
gamepad_icons = [];
control_icons_scale = 1;
control_icons_y_offset = -18;

discovery_mode = MENU_DISCOVERY_MODE.NONE;
active_key_config = -1;
menu_alpha = new Tween(1, 0, 0, 1, TWEEN_LIMIT_MODE.CLAMP, true, function() {});
view_scroll_progress_y = new Tween(0, 0, -1, 1, TWEEN_LIMIT_MODE.CLAMP, true, function() {});
view_scroll_arrow_height = sprite_get_height(view_scroll_arrows_spr);

next_menu = noone;
on_fade_out_end = -1;
on_fade_out_end_args = [];