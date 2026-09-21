/// @desc	 Bilinear interpolation
/// @param {real} _a
/// @param {real} _b
/// @param {real} _c
/// @param {real} _d 
/// @param {real} _w1
/// @param {real} _w2
function blin(_a, _b, _c, _d, _w1, _w2) {
	var _ab = lerp(_a, _b, _w1);
	var _cd = lerp(_c, _d, _w1);
	return lerp(_ab, _cd, _w2);
}