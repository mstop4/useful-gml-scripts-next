event_inherited();

num_items = 0;
pos = 0;
items = [];

view_area = new Vector2(0, 0);

#region View

/// @returns {Bool}
function update_view() {
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
	show_debug_message($"Scroll Delta: {_delta}");
	/*view_scroll_progress_y.v = _delta;
	view_scroll_progress_y.d = -_delta/view_scroll_duration;*/
}

#endregion

#region Insert Items

/// @param {Pointer.FlexPanelNode} _node
/// @param {Struct.FlexMenuItem} _item
function _insert_item(_node, _item) {
	flexpanel_node_insert_child(root_node, _node, num_items);
	array_push(items, _item);
	num_items++;
}

/// @param {Struct} _config
//       - {string} label 
/// @param {bool} _update_layout
function add_item(_config, _update_layout = false) {
	var _root_node = _create_simple_node(_config.label);
	
	var _item = new FlexMenuItem({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node
	});
	
	_insert_item(_node, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
}

/// @param {Struct} _config
//       - {string} label 
/// @param {bool} _update_layout
function add_divider(_config, _update_layout = false) {
	var _root_node = _create_simple_node(_config.label);
	
	var _item = new FlexMenuDivider({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node
	});
	
	_insert_item(_root_node, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
}

/// @param {Struct} _config
//       - {string}      label 
//       - {function}    on_confirm_func
//       - {array}       on_confirm_args
//       - {boolean}     silent_on_confirm
/// @param {bool} _update_layout
function add_selectable(_config, _update_layout = false) {
	var _root_node = _create_simple_node(_config.label);
	
	var _item = new FlexMenuSelectable({
		parent_menu: id,
		label: _config.label,
		root_node: _root_node,
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		silent_on_confirm: _config.silent_on_confirm
	});
	
	_insert_item(_root_node, _item);
	
	if (_update_layout) {
		update_layout();
		update_view_area();
	}
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
function add_valued_selectable(_config, _update_layout = false) {
	var _value_node_width = _config.value_node_width > -1
		? _config.value_node_width
		: value_node_default_width
	var _nodes = _create_spinner_node(_config.label, _value_node_width);

	var _item = new FlexMenuValuedSelectable({
		parent_menu: id,
		label: _config.label,
		root_node: _nodes.root,
		label_node: _nodes.label,
		left_node: _nodes.left,
		value_node: _nodes.value,
		right_node: _nodes.right,
		init_value: _config.init_value,
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
}

/// @param {Struct} _config
//       - {string}      label
//       - {real}        value_node_width
//       - {array}       values
//       - {any}				 init_index
//       - {function} on_confirm_func
//       - {array}    on_confirm_args
//       - {function} on_change_func
//       - {array}    on_change_args
//       - {boolean}  silent_on_confirm
//       - {boolean}  silent_on_change
/// @param {bool} _update_layout
function add_spinner(_config, _update_layout = false) {
	var _value_node_width = _config.value_node_width > -1
		? _config.value_node_width
		: value_node_default_width
	var _nodes = _create_spinner_node(	_config.label, _value_node_width);

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
function add_key_config(_config, _update_layout = false) {
	var _value_node_width = _config.value_node_width > -1
		? _config.value_node_width
		: value_node_default_width
	
	var _nodes = _create_key_config_node(
		_config.label,
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
}

#endregion