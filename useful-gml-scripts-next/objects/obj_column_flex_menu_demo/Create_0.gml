my_player = inst_control_manager.get_player(0);

menu = instance_create_layer(32, 64, "Instances", obj_ugmls_column_flex_menu, {
	player_controller: my_player,
	menu_max_width: "25%",
	item_height: 32,
	item_font: fnt_demo,
	cursor_spr: spr_arrow,
	cursor_move_sfx: snd_menu_move
});

menu.add_item("Foo");
menu.add_item("Bar");
menu.add_item("Baz");

menu.update_layout();