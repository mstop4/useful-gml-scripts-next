event_inherited();

show_debug_message($"{menu_width_items}, {menu_height_items}"); 

items = ds_grid_create(menu_width_items, menu_height_items);
pos = new Vector2(0, 0);
view_area = new Rectangle(0, 0, 0, 0);
view_scroll_progress_x = new Tween(0, 0, -1, 1, TWEEN_LIMIT_MODE.CLAMP, true, undefined, []);

function create_menu_structure() {
	root_node = flexpanel_create_node({
		name: "root",
		left: x,
		top: y,
		width: menu_max_width,
		height: menu_max_height,
	});
	
	alignment_node = flexpanel_create_node({
		name: "alignment",
		width: "100%",
		display: "flex",
		flexDirection: "row",
		alignItems: "center"
	});

	item_list_node = flexpanel_create_node({
		name: "item_list",
		height: menu_height_items * (item_height + item_padding * 2),
		display: "flex",
		flexDirection: "column",
		alignItems: "center"
	});
	
	scroll_up_node = flexpanel_create_node({
		name: "scroll_up",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});
	
	scroll_down_node = flexpanel_create_node({
		name: "scroll_down",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});
	
	scroll_left_node = flexpanel_create_node({
		name: "scroll_left",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});
	
	scroll_right_node = flexpanel_create_node({
		name: "scroll_right",
		width: view_scroll_arrows_height,
		height: view_scroll_arrows_height,
	});

	flexpanel_node_insert_child(root_node, alignment_node, 0);
	flexpanel_node_insert_child(alignment_node, scroll_right_node, 0);
	flexpanel_node_insert_child(alignment_node, item_list_node, 0);
	flexpanel_node_insert_child(alignment_node, scroll_left_node, 0);
	flexpanel_node_insert_child(item_list_node, scroll_down_node, 0);
	flexpanel_node_insert_child(item_list_node, scroll_up_node, 0);
}

create_menu_structure();