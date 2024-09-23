root_node = flexpanel_create_node({
	name: "root",
	left: x,
	top: y,
	width: "80%",
	height: 600,
	padding: 4
});

function update_layout() {
	flexpanel_calculate_layout(root_node, room_width, room_height, flexpanel_direction.LTR);
}

function destroy() {
	flexpanel_delete_node(root_node, true);
}