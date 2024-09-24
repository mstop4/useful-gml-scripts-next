event_inherited();

num_items = 0;
pos = 0;
items = [];

/// @param {string} _name
function add_item(_name) {
	var _node = flexpanel_create_node({
		name: _name,
		width: item_width,
		height: item_height,
		padding: item_padding,
		margin: item_margin,
		marginLeft: item_margin + cursor_width
	});
	
	var _item = new FlexMenuItem({
		parent_menu: id,
		node: _node
	});
	
	flexpanel_node_insert_child(root_node, _node, num_items);
	array_push(items, _item);
	num_items++;
}