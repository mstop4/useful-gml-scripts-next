root_node = flexpanel_create_node({
	name: "root",
	left: x,
	top: y,
	width: menu_max_width,
	height: menu_max_height,
	padding: menu_padding
});

control_state = new MenuControlState(player_controller);

active_key_config = -1;
discovery_mode = FLEX_MENU_DISCOVERY_MODE.NONE;

view_scroll_progress_y = new Tween(0, 0, -1, 1, TWEEN_LIMIT_MODE.CLAMP, true, undefined);

/// @param {string} _percent_str
/// @param {real} _full_value
function convert_percent_to_px(_percent_str, _full_value) {
	// TODO: This won't work with strings like "%100%%%1234%"
	if (is_string(_percent_str)) {
		var _percent_pos = string_pos("%", _percent_str);
		if (_percent_pos == 0) return 0;
		
		var _percent_value_str = string_copy(_percent_str, 1, _percent_pos - 1);
		var _percent_value = real(_percent_value_str);
		return _percent_value * _full_value;
	}
	
	else return 0;
}

#region Node Creation

/// @param {string} _name
function _create_simple_node(_name) {
	return flexpanel_create_node({
		name: $"{_name}_root",
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_offset_x,
		flexDirection: "row"
	});
}

/// @param {string} _name
/// @param {real} _value_node_width
function _create_spinner_node(_name, _value_node_width) {
	var _root_node = flexpanel_create_node({
		name: $"{_name}_root",
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_offset_x,
		flexDirection: "row"
	});
	
	var _label_node = flexpanel_create_node({
		name: $"{_name}_label",
		flexGrow: 1
	});
	
	var _left_node = flexpanel_create_node({
		name: $"{_name}_left",
		width: _value_node_width
	});
	
	var _value_node = flexpanel_create_node({
		name: $"{_name}_value",
		width: _value_node_width
	});
	
	var _right_node = flexpanel_create_node({
		name: $"{_name}_right",
		width: _value_node_width
	});
	
	flexpanel_node_insert_child(_root_node, _label_node, 0);
	flexpanel_node_insert_child(_root_node, _left_node, 1);
	flexpanel_node_insert_child(_root_node, _value_node, 2);
	flexpanel_node_insert_child(_root_node, _right_node, 3);	
	
	return {
		root: _root_node,
		label: _label_node,
		left: _left_node,
		value: _value_node,
		right: _right_node,
	};
}

/// @param {string} _name
/// @param {real} _num_bindings
/// @param {real} _value_node_width
function _create_key_config_node(_name, _num_bindings, _value_node_width) {
	var _root_node = flexpanel_create_node({
		name: $"{_name}_root",
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_offset_x,
		flexDirection: "row"
	});
	
	var _label_node = flexpanel_create_node({
		name: $"{_name}_label",
		flexGrow: 1
	});
	
	flexpanel_node_insert_child(_root_node, _label_node, 0);
	
	var _binding_nodes = [];
	
	for (var _i=0; _i<_num_bindings; _i++) {
		var _binding_node = flexpanel_create_node({
			name: $"{_name}_binding_{_i}",
			width: _value_node_width
		});
		
		flexpanel_node_insert_child(_root_node, _binding_node, _i + 1);
		array_push(_binding_nodes, _binding_node);
	}
	
	return {
		root: _root_node,
		label: _label_node,
		bindings: _binding_nodes
	};
}

#endregion

function update_layout() {
	flexpanel_calculate_layout(root_node, room_width, room_height, flexpanel_direction.LTR);
}

/// @param {bool} _visible
/// @param {bool} _immediate
function toggle_visibility(_visible, _immediate = false) {
	if (_immediate) {
		menu_alpha.v = _visible;
		visible = _visible;
		enabled = _visible;
	} else {
		enabled = false;
		visible = true;
		if (_visible) {
			menu_alpha.v = 0;
			menu_alpha.d = 1/menu_fade_duration;
		} else {
			menu_alpha.v = 1;
			menu_alpha.d = -1/menu_fade_duration;
		}
	}
}

_on_visibility_fade_end = method(self, function() {
	if (menu_alpha.v == 0) {
		visible = false;
	} else {
		enabled = true;
	}
});

#region Drawing

/// @param {Struct.FlexMenuSpinnerBase} _item
/// @param {string} _item_label
/// @param {real} _y_offset
function _draw_spinner_base(_item, _item_label, _y_offset) {
	var _item_value = _item.get_value();
	var _label_node_pos = flexpanel_node_layout_get_position(_item.label_node, false);
	var _value_node_pos = flexpanel_node_layout_get_position(_item.value_node, false);
	var _left_node_pos = flexpanel_node_layout_get_position(_item.left_node, false);
	var _right_node_pos = flexpanel_node_layout_get_position(_item.right_node, false);
			
	if (item_draw_border) {
		draw_rectangle(_label_node_pos.left,
			_label_node_pos.top + _y_offset,
			_label_node_pos.left + _label_node_pos.width,
			_label_node_pos.top + _label_node_pos.height + _y_offset,
			true
		);
				
		draw_rectangle(_value_node_pos.left,
			_value_node_pos.top + _y_offset,
			_value_node_pos.left + _value_node_pos.width,
			_value_node_pos.top + _value_node_pos.height + _y_offset,
			true
		);
		
		draw_rectangle(_left_node_pos.left,
			_left_node_pos.top + _y_offset,
			_left_node_pos.left + _left_node_pos.width,
			_left_node_pos.top + _left_node_pos.height + _y_offset,
			true
		);

		draw_rectangle(_right_node_pos.left,
			_right_node_pos.top + _y_offset,
			_right_node_pos.left + _right_node_pos.width,
			_right_node_pos.top + _right_node_pos.height + _y_offset,
			true
		);
	}
	
	draw_set_font(label_font);
	draw_text(
		_label_node_pos.left + _label_node_pos.paddingLeft,
		_label_node_pos.top + _label_node_pos.height / 2 + _y_offset,
		_item_label
	);
			
	draw_set_halign(fa_center);
	draw_set_font(value_font);
	draw_text(
		_value_node_pos.left + _value_node_pos.width / 2,
		_value_node_pos.top + _value_node_pos.height / 2 + _y_offset,
		_item_value
	);
}

/// @param {Struct.FlexMenuSpinnerBase} _item
/// @param {real} _y_offset
/// @param {real} _base_alpha
function _draw_spinner_arrows(_item, _y_offset, _base_alpha) {
	var _left_node_pos = flexpanel_node_layout_get_position(_item.left_node, false);
	var _right_node_pos = flexpanel_node_layout_get_position(_item.right_node, false);
			
	draw_sprite_ext(spinner_scroll_arrows_spr, 0,
		_left_node_pos.left + _left_node_pos.width / 2,
		_left_node_pos.top + _left_node_pos.height / 2 + _y_offset,
		1, 1, 90, c_white, _base_alpha
	);
			
	draw_sprite_ext(spinner_scroll_arrows_spr, 0,
		_right_node_pos.left + _right_node_pos.width / 2,
		_right_node_pos.top + _right_node_pos.height / 2 + _y_offset,
		1, 1, 270, c_white, _base_alpha
	);
}

/// @param {Struct.FlexMenuKeyConfig} _item
/// @param {Struct} _node_pos
/// @param {real} _index
/// @param {real} _y_offset
/// @param {real} _base_alpha
function _draw_binding_cursor(_item, _node_pos, _index, _y_offset, _base_alpha) {
	if (discovery_mode != MENU_DISCOVERY_MODE.NONE
		&& active_key_config == _item
		&& _index == _item.current_binding_index) {
		draw_sprite_ext(sub_cursor_spr, 0,
			_node_pos.left + _node_pos.width / 2 - binding_cursor_offset_x,
			_node_pos.top + _node_pos.height / 2 + _y_offset,
			1, 1, 0, c_white, _base_alpha
		);
	}
}

/// @param {Struct.FlexMenuKeyConfig} _item
/// @param {string} _item_label
/// @param {real} _y_offset
/// @param {real} _base_alpha
function _draw_key_config(_item, _item_label, _y_offset, _base_alpha) {
	var _label_node = _item.label_node;
	var _label_node_pos = flexpanel_node_layout_get_position(_label_node, false);
	
	if (item_draw_border) {
		draw_rectangle(_label_node_pos.left,
			_label_node_pos.top + _y_offset,
			_label_node_pos.left + _label_node_pos.width,
			_label_node_pos.top + _label_node_pos.height + _y_offset,
			true
		);
	}
	
	draw_set_halign(fa_left);
	draw_set_font(label_font);
	draw_text(
		_label_node_pos.left + _label_node_pos.paddingLeft,
		_label_node_pos.top + _label_node_pos.height / 2 + _y_offset,
		_item_label
	);
	
	var _binding_nodes = _item.binding_nodes;
	var _num_nodes = array_length(_binding_nodes);
	var _cur_binding_index = 0;
	
	draw_set_halign(fa_center);
	draw_set_font(value_font);
		
	// Draw keyboard bindings
	for (var _i=0; _i<KEYBOARD_MAX_BINDINGS_PER_CONTROL; _i++) {
		var _cur_node = _binding_nodes[_cur_binding_index];
		var _cur_node_pos = flexpanel_node_layout_get_position(_cur_node, false);
		
		if (item_draw_border) {
			draw_rectangle(_cur_node_pos.left,
				_cur_node_pos.top + _y_offset,
				_cur_node_pos.left + _cur_node_pos.width,
				_cur_node_pos.top + _cur_node_pos.height + _y_offset,
				true
			);
		}

		if (use_control_icons) {
			var _item_icon_index = _item.get_icon_index(CONTROL_TYPE.KEYBOARD_AND_MOUSE, _i);
			draw_sprite_ext(keyboard_icons[keyboard_icons_index],
				_item_icon_index,
				_cur_node_pos.left + _cur_node_pos.width / 2,
				_cur_node_pos.top + _cur_node_pos.height / 2 + _y_offset,
				control_icons_scale, control_icons_scale,
				0, c_white, _base_alpha
			);
		} else {
			var _item_value = _item.get_text_value(CONTROL_TYPE.KEYBOARD_AND_MOUSE, _i);
			draw_text(
				_cur_node_pos.left + _cur_node_pos.width / 2,
				_cur_node_pos.top + _cur_node_pos.height / 2 + _y_offset,
				_item_value
			);
		}
		
		_draw_binding_cursor(_item, _cur_node_pos, _cur_binding_index);
		_cur_binding_index++;
	}
	
	// Draw gamepad bindings
	for (var _i=0; _i<GAMEPAD_MAX_BINDINGS_PER_CONTROL; _i++) {
		var _cur_node = _binding_nodes[_cur_binding_index];
		var _cur_node_pos = flexpanel_node_layout_get_position(_cur_node, false);
		
		if (item_draw_border) {
			draw_rectangle(_cur_node_pos.left,
				_cur_node_pos.top + _y_offset,
				_cur_node_pos.left + _cur_node_pos.width,
				_cur_node_pos.top + _cur_node_pos.height + _y_offset,
				true
			);
		}
		
		if (use_control_icons) {
			var _item_icon_index = _item.get_icon_index(CONTROL_TYPE.GAMEPAD, _i);
			draw_sprite_ext(gamepad_icons[gamepad_icons_index],
				_item_icon_index,
				_cur_node_pos.left + _cur_node_pos.width / 2,
				_cur_node_pos.top + _cur_node_pos.height / 2 + _y_offset,
				control_icons_scale, control_icons_scale,
				0, c_white, _base_alpha
			);
		} else {
			var _item_value = _item.get_text_value(CONTROL_TYPE.GAMEPAD, _i);
			draw_text(
				_cur_node_pos.left + _cur_node_pos.width / 2,
				_cur_node_pos.top + _cur_node_pos.height / 2 + _y_offset,
				_item_value
			);
		}
		
		_draw_binding_cursor(_item, _cur_node_pos, _cur_binding_index);
		_cur_binding_index++;
	}
}

/// @param {Struct.FlexMenuItem} _item
/// @param {real} _i
/// @param {real} _item_index_offset
/// @param {real} _scroll_y_offset
/// @param {real} _base_alpha
function draw_menu_item(_item, _i, _item_index_offset, _scroll_y_offset, _base_alpha) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(_base_alpha);
	var _node = _item.root_node;
	var _node_pos = flexpanel_node_layout_get_position(_node, false);
	var _item_label = _item.label;
	var _y_offset = -_item_index_offset * (_node_pos.height + _node_pos.marginTop + _node_pos.marginBottom) + _scroll_y_offset;
	
	// Border
	if (item_draw_border) {
		draw_rectangle(
			_node_pos.left,
			_node_pos.top + _y_offset,
			_node_pos.left + _node_pos.width,
			_node_pos.top + _node_pos.height + _y_offset,
			true
		);
	}

	// Contents
	switch (_item.type) {
		case FLEX_MENU_ITEM_TYPE.ITEM:
		case FLEX_MENU_ITEM_TYPE.SELECTABLE:
		case FLEX_MENU_ITEM_TYPE.DIVIDER:
			draw_set_font(label_font);
			draw_text(
				_node_pos.left + _node_pos.paddingLeft,
				_node_pos.top + _node_pos.height / 2 + _y_offset,
				_item_label
			);
			break;
		
		case FLEX_MENU_ITEM_TYPE.SPINNER_BASE:
		case FLEX_MENU_ITEM_TYPE.VALUED_SELECTABLE:
			_draw_spinner_base(_item, _item_label, _y_offset);
			break;
		
		case FLEX_MENU_ITEM_TYPE.SPINNER:
			_draw_spinner_base(_item, _item_label, _y_offset);
			_draw_spinner_arrows(_item, _y_offset, _base_alpha);
			break;
			
		case FLEX_MENU_ITEM_TYPE.KEY_CONFIG:
			_draw_key_config(_item, _item_label, _y_offset, _base_alpha);
			break;
			
		default:
			draw_set_font(label_font);
			draw_text(
				_node_pos.left + _node_pos.paddingLeft,
				_node_pos.top + _node_pos.paddingTop + _y_offset,
				$"Unknown Item: {_item_label}"
			);
	}
	
	// Cursor
	if (enabled && pos == _i) {
		draw_sprite_ext(
			cursor_spr,
			0,
			_node_pos.left - cursor_offset_x,
			_node_pos.top + _node_pos.height / 2 + _y_offset,
			1, 1, 0, c_white, menu_alpha.v
		);
	}
}

#endregion

function destroy() {
	flexpanel_delete_node(root_node, true);
}

menu_alpha = new Tween(1, 0, 0, 1, TWEEN_LIMIT_MODE.CLAMP,  true, _on_visibility_fade_end);