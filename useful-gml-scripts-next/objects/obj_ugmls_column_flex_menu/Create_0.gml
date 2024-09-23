event_inherited();

num_items = 0;
items = [];

/// @param {string} _name
function add_item(_name) {
	var _node = flexpanel_create_node({
		name: _name,
		width: "100%",
		padding: 4,
		height: 50
	});
	
	var _item = new FlexMenuItem({
		parent_menu: id,
		node: _node
	});
	
	flexpanel_node_insert_child(root_node, _node, num_items);
	array_push(items, _item);
	num_items++;
}