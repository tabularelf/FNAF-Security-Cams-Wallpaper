if (wallpaper_config[$ "animatronics"] != undefined) {
	if (wallpaper_config.animatronics[$ "freddy_ai"] != undefined) {
		game_settings.freddyAI = wallpaper_config.animatronics.freddy_ai;
	}
	
	if (wallpaper_config.animatronics[$ "chica_ai"] != undefined) {
		game_settings.chicaAI = wallpaper_config.animatronics.chica_ai;
	}
	
	if (wallpaper_config.animatronics[$ "foxy_ai"] != undefined) {
		game_settings.foxyAI = wallpaper_config.animatronics.foxy_ai;
	}
	
	if (wallpaper_config.animatronics[$ "bonnie_ai"] != undefined) {
		game_settings.bonnieAI = wallpaper_config.animatronics.bonnie_ai;
	}
}

if (wallpaper_config[$ "general"] != undefined) {
	if (wallpaper_config.general[$ "garble"] != undefined) {
		game_settings.garbledCamera = wallpaper_config.general.garble;
	}
	
	if (wallpaper_config.general[$ "is_sunday"] != undefined) {
		game_settings.isFirstDaySunday = wallpaper_config.general.is_sunday;
	}
	
	if (wallpaper_config.general[$ "camera_auto_shuffle"] != undefined) {
		game_settings.cameraShuffle = wallpaper_config.general.camera_auto_shuffle;
	}
	
	if (wallpaper_config.general[$ "hallway_west_a_light_flicker"] != undefined) {
		game_settings.lightFlicker =wallpaper_config.general.hallway_west_a_light_flicker;
	}
	
	if (wallpaper_config.general[$ "camera_flash_alpha"] != undefined) {
		game_settings.flashAlpha = wallpaper_config.general.camera_flash_alpha;
	}
	
	if (wallpaper_config.general[$ "camera_static_alpha"] != undefined) {
		game_settings.staticAlpha = wallpaper_config.general.camera_static_alpha;
	}
}

var _muted = global.game_settings.volume_enabled;
var _amb = global.game_settings.volume_ambient;
var _ui = global.game_settings.volume_ui;
var _anim = global.game_settings.volume_animatronics;

if (wallpaper_config[$ "audio"] != undefined) {
	if (wallpaper_config.audio[$ "mute_audio"] != undefined) {
		_muted = !wallpaper_config.audio.mute_audio;
	}
	
	if (wallpaper_config.audio[$ "ambience_audio"] != undefined) {
		_amb = wallpaper_config.audio.ambience_audio;
	}
	
	if (wallpaper_config.audio[$ "animatronic_audio"] != undefined) {
		_anim = wallpaper_config.audio.animatronic_audio;
	}
	
	if (wallpaper_config.audio[$ "ui_audio"] != undefined) {
		_ui = wallpaper_config.audio.ui_audio;
	}
}

audio_set_master_gain(0, _muted);
update_game_settings(
	_muted, 
	game_settings.last_location, 
	_amb, 
	_anim, 
	_ui
);