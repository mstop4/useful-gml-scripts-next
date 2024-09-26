event_inherited();

num_items = 0;
pos = 0;
items = [];

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
	}
}

/// @param {Struct} _config
//       - {string}      label
//       - {any}				 init_value
//       - {function} on_confirm_func
//       - {array}    on_confirm_args
//       - {function} on_change_func
//       - {array}    on_change_args
//       - {boolean}  silent_on_confirm
//       - {boolean}  silent_on_change
/// @param {bool} _update_layout
function add_valued_selectable(_config, _update_layout = false) {
	var _nodes = _create_spinner_node(	_config.label);

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
	}
}
