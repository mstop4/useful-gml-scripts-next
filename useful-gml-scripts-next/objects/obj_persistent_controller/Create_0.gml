var _player_index = inst_control_manager.add_player();
my_player = inst_control_manager.get_player(_player_index);
quit_timer = quit_timer_length;
surf_quit_meter = surface_create(32, 32);
is_quitting = false;

reset_all_control_bindings(my_player);