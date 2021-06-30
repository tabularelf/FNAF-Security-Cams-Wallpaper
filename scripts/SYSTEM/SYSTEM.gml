if (os_browser != browser_not_a_browser) {
	//gml_pragma("PNGCrush");
}

function image_speed_get(_sprite) {
  return sprite_get_speed_type(_sprite) == spritespeed_framespergameframe ? sprite_get_speed(_sprite) :   sprite_get_speed(_sprite)/game_get_speed(gamespeed_fps);
}

#macro WALLPAPER_VERSION 2

function update_game_settings(_volume_enabled, _last_location, _volume_ambient, _volume_animatronics, _volume_ui) {
	var _struct = {
		version:				WALLPAPER_VERSION,
		volume_enabled:			_volume_enabled,
		volume_ambient:			is_undefined(_volume_ambient)		? game_settings.volume_ambient : _volume_ambient,
		volume_animatronics:	is_undefined(_volume_animatronics)	? game_settings.volume_animatronics : _volume_animatronics,
		volume_ui:				is_undefined(_volume_ui)			? game_settings.volume_ui : _volume_ui,
		last_location:			_last_location
	}
	
	game_settings = _struct;
}


function save_settings() {
		var _buff = buffer_create(1, buffer_grow,1);
		buffer_write(_buff,buffer_string,json_stringify(obj_cams.game_settings));
		buffer_save(_buff,"settings.txt");
		buffer_delete(_buff);
}

/// @func normalize_ext
/// @description Converts one range set to another, and then normalizes the value.
/// @param Min1
/// @param Max1
/// @param Min2
/// @param Max2
/// @param Value
function normalize_ext(_min1,_max1,_min2,_max2,_value) {
	return _min2 + (_value - _min1) * (_max2 - _min2) / (_max1 - _min1);
}

/// @func normalize
/// @description Normalizes the value.
/// @param Min
/// @param Max
/// @param Value
function normalize(_min, _max, _value) {
	return normalize_ext(_min, _max, 0, 1, _value);
}