/// @desc fade out end
visible = false;

if (is_callable(on_fade_out_end)) {
	// Feather ignore GM1021
	// Feather ignore once GM1060
	self.on_fade_out_end(on_fade_out_end_args);
	// Feather ignore once GM1043
	self.on_fade_out_end = pointer_null;
	// Feather restore GM1021
}

if (instance_exists(next_menu)) {
	next_menu.menu_fade_in();
}

next_menu = noone;