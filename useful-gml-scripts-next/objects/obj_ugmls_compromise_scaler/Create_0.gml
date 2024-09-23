application_surface_draw_enable(false);
app_res = new Vector2(
	surface_get_width(application_surface),
	surface_get_height(application_surface)
);

saved_window_size = new Vector2(
	window_get_width(),
	window_get_height()
);

cur_window_size = new Vector2(
	saved_window_size.x,
	saved_window_size.y
);

integer_scale = 1;
true_scale = 1;
fullscreen_mode = 0;

if (window_get_fullscreen()) {
	fullscreen_mode = window_get_borderless_fullscreen()
		? UGMLS_COMPROMISE_SCALER_SCREEN_MODE.BORDERLESS_FULLSCREEN
		: UGMLS_COMPROMISE_SCALER_SCREEN_MODE.FULLSCREEN;
} else {
	fullscreen_mode = UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED;
}

upscale_surf = surface_create(app_res.x * integer_scale, app_res.y * integer_scale);

function _calculate_scale_factors() {
	var _width_ratio = cur_window_size.x / app_res.x;
	var _height_ratio = cur_window_size.y / app_res.y;
	
	true_scale = min(_width_ratio, _height_ratio);
	integer_scale = floor(true_scale);
}

_on_screen_mode_change = method(id, function () {
	_calculate_scale_factors();
	surface_resize(upscale_surf, app_res.x * integer_scale, app_res.y * integer_scale);
});

function change_application_surface_size(_width, _height) {
	surface_resize(application_surface, _width, _height);
	app_res.x = _width;
	app_res.y = _height;
}

function change_screen_mode(_screen_mode, _width = -1, _height = -1) {
	switch (_screen_mode) {
		case UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED:
			if (_width != -1) saved_window_size.x = _width;
			if (_height != -1) saved_window_size.y = _height;
			
			cur_window_size.x = saved_window_size.x;
			cur_window_size.y = saved_window_size.y;
			
			window_set_fullscreen(false);
			window_set_size(saved_window_size.x, saved_window_size.y);
			window_center();
			
			_calculate_scale_factors();
			surface_resize(upscale_surf, app_res.x * integer_scale, app_res.y * integer_scale);
			fullscreen_mode = _screen_mode;
			break;

		case UGMLS_COMPROMISE_SCALER_SCREEN_MODE.FULLSCREEN:	
			cur_window_size.x = display_get_width();
			cur_window_size.y = display_get_height();
			
			window_enable_borderless_fullscreen(false);
			window_set_fullscreen(true);
			
			call_later(1, time_source_units_frames, _on_screen_mode_change);
			fullscreen_mode = _screen_mode;
			break;
		case UGMLS_COMPROMISE_SCALER_SCREEN_MODE.BORDERLESS_FULLSCREEN:
			cur_window_size.x = display_get_width();
			cur_window_size.y = display_get_height();
			
			window_enable_borderless_fullscreen(true);
			window_set_fullscreen(true);
			
			call_later(1, time_source_units_frames, _on_screen_mode_change);
			fullscreen_mode = _screen_mode;
			break;
		default:
			show_debug_message("WAT");
	}
}