event_inherited();

num_items = 0;
pos = 0;
items = [];

/// @param {string} _name
function _create_node(_name) {
	return flexpanel_create_node({
		name: _name,
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_width
	});
}

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
	var _node = _create_node(_config.label);
	
	var _item = new FlexMenuItem({
		parent_menu: id,
		node: _node
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
	var _node = _create_node(_config.label);
	
	var _item = new FlexMenuDivider({
		parent_menu: id,
		node: _node
	});
	
	_insert_item(_node, _item);
	
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
	var _node = _create_node(_config.label);
	
	var _item = new FlexMenuSelectable({
		parent_menu: id,
		node: _node,
		on_confirm_func: _config.on_confirm_func,
		on_confirm_args: _config.on_confirm_args,
		silent_on_confirm: _config.silent_on_confirm
	});
	
	_insert_item(_node, _item);
	
	if (_update_layout) {
		update_layout();
	}
}
