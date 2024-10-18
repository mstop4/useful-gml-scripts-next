event_inherited();

num_items = 0;
pos = 0;
items = [];

view_area = new Vector2(0, 0);

function create_menu_structure() {
	root_node = flexpanel_create_node({
		name: "root",
		left: x,
		top: y,
		width: menu_max_width,
		height: menu_max_height
	});

	item_list_node = flexpanel_create_node({
		name: "item_list",
		height: "100%",
		flexDirection: "column",
		alignItems: "center"
	});
	
	scroll_up_node = flexpanel_create_node({
		name: "scroll_up",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height
	});
	
	scroll_down_node = flexpanel_create_node({
		name: "scroll_down",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height
	});

	flexpanel_node_insert_child(root_node, item_list_node, 0);
	flexpanel_node_insert_child(item_list_node, scroll_down_node, 0);
	flexpanel_node_insert_child(item_list_node, scroll_up_node, 0);
}

#region View

/// @returns {Bool}
function scroll_view() {
	var _changed = false;

	if (view_height > 0) {
		if (pos < view_area.x) {
			view_area.x = pos;
			view_area.y = pos + view_height - 1;
			_changed = true;
		} else if (pos > view_area.y) {
			view_area.y = pos;
			view_area.x = pos - (view_height - 1);
			_changed = true;
		}
	}

	return _changed;
}

function update_view_area() {
	if (view_height < 1) {
		view_area.x = 0;
		view_area.y = num_items - 1;
	} else {
		view_area.x = min(pos, num_items - view_height - 1);
		view_area.y = view_area.x + view_height - 1;
	}
}

/// @param {real} _delta
function start_scroll(_delta) {
	view_scroll_progress_y.v = _delta;
	view_scroll_progress_y.d = -_delta/view_scroll_duration;
}

function reset_scroll() {
	view_scroll_progress_y.v = 0;
	view_scroll_progress_y.d = 0;
}

#endregion

#region Insert Items

/// @param {Pointer.FlexPanelNode} _node
/// @param {Struct.FlexMenuItem} _item
function _insert_item(_node, _item) {
	num_items++;
	flexpanel_node_insert_child(item_list_node, _node, num_items);
	array_push(items, _item);
}

/// @param {Struct} _config
//       - {string} label
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuItem}
function add_item(_config, _update_layout = false) {
	var _root_node = _create_simple_node(_config.label, "100%");
	
	var _item = new FlexMenuItem({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node,
		item_data: {
			index: num_items + 1
		}
	});
	
	_insert_item(_root_node, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

/// @param {Struct} _config
//       - {string} label
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuDivider}
function add_divider(_config, _update_layout = false) {
	var _root_node = _create_simple_node(_config.label, "100%");
	
	var _item = new FlexMenuDivider({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node,
		item_data: {
			index: num_items + 1
		}
	});
	
	_insert_item(_root_node, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

/// @param {Struct} _config
//       - {string}      label 
//       - {function}    on_confirm_func
//       - {array}       on_confirm_args
//       - {boolean}     silent_on_confirm
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuSelectable}
function add_selectable(_config, _update_layout = false) {
	var _root_node = _create_simple_node(_config.label, "100%");
	
	var _item = new FlexMenuSelectable({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node,
		item_data: {
			index: num_items + 1
		},
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		silent_on_confirm: _config.silent_on_confirm
	});
	
	_insert_item(_root_node, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

/// @param {Struct} _config
//       - {string}      label
//       - {real}        value_node_width
//       - {any}				 init_value
//       - {function} on_confirm_func
//       - {array}    on_confirm_args
//       - {function} on_change_func
//       - {array}    on_change_args
//       - {boolean}  silent_on_confirm
//       - {boolean}  silent_on_change
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuValuedSelectable}
function add_valued_selectable(_config, _update_layout = false) {
	var _value_node_width = _config.value_node_width > -1
		? _config.value_node_width
		: value_node_default_width
	var _nodes = _create_spinner_node(_config.label, "100%", _value_node_width);

	var _item = new FlexMenuValuedSelectable({
		parent_menu: id,
		label: _config.label,
		root_node: _nodes.root,
		label_node: _nodes.label,
		left_node: _nodes.left,
		value_node: _nodes.value,
		right_node: _nodes.right,
		init_value: _config.init_value,
		item_data: {
			index: num_items + 1
		},
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		on_change_func: _config.on_change_func,
		on_change_args: _config.on_change_args,
		silent_on_confirm: _config.silent_on_confirm,
		silent_on_change: _config.silent_on_change,
	});
	
	_insert_item(_nodes.root, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

/// @param {Struct} _config
//       - {string}      label
//       - {real}        value_node_width
//       - {array}       values
//       - {any}				 init_index
//       - {bool}        lockable
//       - {function} on_confirm_func
//       - {array}    on_confirm_args
//       - {function} on_change_func
//       - {array}    on_change_args
//       - {boolean}  silent_on_confirm
//       - {boolean}  silent_on_change
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuSpinner}
function add_spinner(_config, _update_layout = false) {
	var _value_node_width = _config.value_node_width > -1
		? _config.value_node_width
		: value_node_default_width
	var _nodes = _create_spinner_node(_config.label, "100%", _value_node_width);

	var _item = new FlexMenuSpinner({
		parent_menu: id,
		label: _config.label,
		root_node: _nodes.root,
		label_node: _nodes.label,
		left_node: _nodes.left,
		value_node: _nodes.value,
		right_node: _nodes.right,
		values: _config.values,
		init_index: _config.init_index,
		lockable: _config.lockable,
		item_data: {
			index: num_items + 1
		},
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		on_change_func: _config.on_change_func,
		on_change_args: _config.on_change_args,
		silent_on_confirm: _config.silent_on_confirm,
		silent_on_change: _config.silent_on_change,
	});
	
	_insert_item(_nodes.root, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

/// @param {Struct} _config
//       - {string}      label
//       - {real}        value_node_width
//       - {real}        control
//       - {array}			 initial_kbm_bindings
//       - {array}			 initial_gamepad_bindings
//       - {function} on_confirm_func
//       - {array}    on_confirm_args
//       - {function} on_change_func
//       - {array}    on_change_args
//       - {boolean}  silent_on_confirm
//       - {boolean}  silent_on_change
/// @param {bool} _update_layout
/// @returns {Struct.FlexMenuKeyConfig}
function add_key_config(_config, _update_layout = false) {
	var _value_node_width = _config.value_node_width > -1
		? _config.value_node_width
		: value_node_default_width
	
	var _nodes = _create_key_config_node(
		_config.label,
		"100%",
		KEYBOARD_MAX_BINDINGS_PER_CONTROL + GAMEPAD_MAX_BINDINGS_PER_CONTROL,
		_value_node_width
	);

	var _item = new FlexMenuKeyConfig({
		parent_menu: id,
		label: _config.label,
		root_node: _nodes.root,
		label_node: _nodes.label,
		binding_nodes: _nodes.bindings,
		control: _config.control,
		initial_kbm_bindings: _config.initial_kbm_bindings,
		initial_gamepad_bindings: _config.initial_gamepad_bindings,
		item_data: {
			index: num_items + 1
		},
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		on_change_func: _config.on_change_func,
		on_change_args: _config.on_change_args,
		silent_on_confirm: _config.silent_on_confirm,
		silent_on_change: _config.silent_on_change,
	});
	
	_insert_item(_nodes.root, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
	
	return _item;
}

#endregion

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
			if (_item_label != "") {
				draw_set_font(label_font);
				draw_text(
					_node_pos.left + _node_pos.paddingLeft,
					_node_pos.top + _node_pos.height / 2 + _y_offset,
					_item_label
				);
			}
			break;

		case FLEX_MENU_ITEM_TYPE.SPINNER_BASE:
		case FLEX_MENU_ITEM_TYPE.VALUED_SELECTABLE:
			_draw_spinner_base(_item, _item_label, _y_offset);
			break;

		case FLEX_MENU_ITEM_TYPE.SPINNER:
			_draw_spinner_base(_item, _item_label, _y_offset);

			if (_item.can_interact() && !_item.is_locked() && pos == _i) {
				_draw_spinner_arrows(_item, _y_offset, _base_alpha);
			}

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
	if (can_interact() && pos == _i) {
		draw_sprite_ext(
			cursor_spr,
			0,
			_node_pos.left,
			_node_pos.top + _node_pos.height / 2 + _y_offset,
			1, 1, 0, c_white, menu_alpha.v
		);
	}
}

#endregion

create_menu_structure();