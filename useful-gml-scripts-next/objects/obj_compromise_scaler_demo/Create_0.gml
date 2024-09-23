resolutions = [
	new Vector2(480, 270),
	new Vector2(640, 360),
	new Vector2(960, 540),
	new Vector2(1280, 720),
	new Vector2(1366, 768),
	new Vector2(1920, 1080),
	new Vector2(2560, 1440),
	new Vector2(3840, 2160)
];
num_resolutions = array_length(resolutions);
cur_resolution = 3;
fullscreen_mode = UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED;
comp_scaler = instance_find(obj_ugmls_compromise_scaler, 0);

mode_names = [
	"Windowed",
	"Fullscreen",
	"Borderless Fullscreen"
];

function change_fullscreen_mode() {
	fullscreen_mode = wrap(fullscreen_mode + 1, UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED, UGMLS_COMPROMISE_SCALER_SCREEN_MODE.BORDERLESS_FULLSCREEN + 1);
	comp_scaler.change_screen_mode(fullscreen_mode);
}

function change_resolution(_delta) {
	cur_resolution = wrap(cur_resolution + _delta, 0, num_resolutions);
	
	comp_scaler.change_screen_mode(
		UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED,
		resolutions[cur_resolution].x,
		resolutions[cur_resolution].y
	);
	
	fullscreen_mode = UGMLS_COMPROMISE_SCALER_SCREEN_MODE.WINDOWED;
}

obj_ugmls_compromise_scaler.change_application_surface_size(room_width, room_height);
obj_ugmls_compromise_scaler.change_screen_mode(
	fullscreen_mode,
	resolutions[cur_resolution].x,
	resolutions[cur_resolution].y
);