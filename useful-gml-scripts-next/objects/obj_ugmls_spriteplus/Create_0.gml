/// @param {Id.Instance} _parent
/// @param {Bool} _force_update
function set_parent(_parent, _force_update = false) {
	parent = _parent;
	
	if (_force_update) self._update_position();
}

/// @param {Real} _x
/// @param {Real} _y
/// @param {Bool} _force_update
function set_offset(_x, _y, _force_update = false) {
	offset_x = _x;
	offset_y = _y;

	if (_force_update) self._update_position();
}

/// @param {Asset.GMSprite} _sprite
function set_sprite(_sprite) {
	sprite_index = _sprite;
}

/// @param {Real} _speed
function set_speed(_speed) {
	img_spd = _speed;
}

function resume() {
	image_speed = img_spd;
}

function stop() {
	image_speed = 0;
}

function reset() {
	image_index = 0;
}

function _update_position() {
	if (instance_exists(parent)) {
		x = parent.x + offset_x;
		y = parent.y + offset_y;
	}
}