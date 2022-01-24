if (os_browser != browser_not_a_browser) {
	gml_pragma("PNGCrush");
}

global.hasStarted = false;

#macro FNAF_VERSION "1.0.8"

function image_speed_get(_sprite) {
  return sprite_get_speed_type(_sprite) == spritespeed_framespergameframe ? sprite_get_speed(_sprite) :   sprite_get_speed(_sprite)/game_get_speed(gamespeed_fps);
}

#macro WALLPAPER_VERSION 3

function init_game_settings() {
	var _game_settings = obj_cams.game_settings;
	_game_settings.version = WALLPAPER_VERSION;
	_game_settings.freddyAI = 0;
	_game_settings.foxyAI = 0;
	_game_settings.chicaAI = 0;
	_game_settings.bonnieAI = 0;
	_game_settings.garbledCamera = true;
	
}

function update_game_settings(_volume_enabled, _last_location, _volume_ambient, _volume_animatronics, _volume_ui) {
	var _v1 = is_undefined(_volume_ambient)		?  obj_cams.game_settings.volume_ambient : _volume_ambient;
	var _v2 = is_undefined(_volume_animatronics)	?  obj_cams.game_settings.volume_animatronics : _volume_animatronics;
	var _v3 = is_undefined(_volume_ui)			?  obj_cams.game_settings.volume_ui : _volume_ui;
	/*var _struct = {
		version:				WALLPAPER_VERSION,
		volume_enabled:			_volume_enabled,
		volume_ambient:			_v1,
		volume_animatronics:	_v2,
		volume_ui:				_v3,
		last_location:			_last_location
	}
	
	show_debug_message("Does this work 2?");
	
	obj_cams.game_settings = _struct;
	return false;*/
	
	obj_cams.game_settings.version = WALLPAPER_VERSION;
	obj_cams.game_settings.last_location = _last_location;
	obj_cams.game_settings.volume_enabled = _volume_enabled;
	obj_cams.game_settings.volume_ambient = _v1;
	obj_cams.game_settings.volume_animatronics = _v2;
	obj_cams.game_settings.volume_ui = _v3;
	show_debug_message(obj_cams.game_settings);
	with(obj_cams) {
		if (global.hasStarted) {
			audioSwitchKitchen();
			audioSwitchPirate();
		}
	}
	
	var _currentAudio = global.currentAudio;
	if (audio_is_playing(_currentAudio.foxyRunning)) {
		audio_sound_gain(_currentAudio.foxyRunning,.6* obj_cams.game_settings.volume_animatronics, 0);	
	}
	
	if (audio_is_playing(_currentAudio.freddyLaugh)) {
		audio_sound_gain(_currentAudio.freddyLaugh, obj_cams.game_settings.volume_animatronics, 0);	
	}
	
	if (audio_is_playing(_currentAudio.knocking)) {
		audio_sound_gain(_currentAudio.knocking, obj_cams.game_settings.volume_animatronics, 0);	
	}
	
	if (audio_is_playing(_currentAudio.blipClick)) {
		audio_sound_gain(_currentAudio.blipClick, obj_cams.game_settings.volume_ui, 0);	
	}
	
	if (audio_is_playing(_currentAudio.buzzFan)) {
		audio_sound_gain(_currentAudio.buzzFan, .3*obj_cams.game_settings.volume_ambient, 0);	
	}
	
	if (audio_is_playing(_currentAudio.VCRSFX)) {
		audio_sound_gain(_currentAudio.VCRSFX, obj_cams.game_settings.volume_ambient, 0);	
	}
	
	if (audio_is_playing(_currentAudio.eerieAmbience)) {
		audio_sound_gain(_currentAudio.eerieAmbience, obj_cams.game_settings.volume_ambient, 0);
	}
	
	if (audio_is_playing(_currentAudio.hallucinations)) {
		audio_sound_gain(_currentAudio.hallucinations, obj_cams.game_settings.volume_animatronics, 0);
	}
	
	if (audio_is_playing(_currentAudio.normalRunningLeft)) {
		audio_sound_gain(_currentAudio.normalRunningLeft, .5*obj_cams.game_settings.volume_animatronics, 0);	
	}
	
	if (audio_is_playing(_currentAudio.normalRunningRight)) {
		audio_sound_gain(_currentAudio.normalRunningRight, .5*obj_cams.game_settings.volume_animatronics, 0);	
	}
	
	if (audio_is_playing(_currentAudio.cameraChange)) {
		audio_sound_gain(_currentAudio.cameraChange,  .6*obj_cams.game_settings.volume_ui, 0);	
	}
}


function save_settings() {
		var _buff = buffer_create(1, buffer_grow,1);
		buffer_write(_buff,buffer_string,json_stringify(obj_cams.game_settings));
		buffer_save(_buff,"settings.txt");
		show_debug_message("Settings saved!");
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