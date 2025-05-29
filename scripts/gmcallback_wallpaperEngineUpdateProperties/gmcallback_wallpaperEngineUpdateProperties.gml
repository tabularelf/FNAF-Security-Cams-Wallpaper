function gmcallback_wallpaperEngineUpdateProperties() {
	var _keyName = wallpaperEngineGetKey();
	var _value = wallpaperEngineGetValue();
	var game_settings = obj_cams.game_settings;
	switch(_keyName) {
		case "fnafmuteaudio": 
			//show_debug_message("Audio Mute Stuff");
			audio_set_master_gain(0, !_value);	
			update_game_settings(!_value, game_settings.last_location);
			save_settings();
		break;
		
		case "fnafambience":
			//show_debug_message("Ambience Stuff");
			update_game_settings(game_settings.volume_enabled, game_settings.last_location, _value, undefined, undefined);
			//show_debug_message(obj_cams.game_settings);
			/*var _array = tag_get_asset_ids("Ambient", asset_sound);
			for(var _i = 0; _i < array_length(_array); ++_i) {
				if (audio_is_playing(_i)) {
					audio_sound_gain(_i, _value, 0);	
				}
			}*/
			
			save_settings();
		break;
		
		case "fnafui":
			//show_debug_message("UI Stuff");
			update_game_settings(game_settings.volume_enabled, game_settings.last_location, undefined, undefined, _value);
			//var _array = tag_get_asset_ids("UI", asset_sound);
			/*for(var _i = 0; _i < array_length(_array); ++_i) {
				if (audio_is_playing(_i)) {
					audio_sound_gain(_i, _value, 0);	
				}
			}*/
			
			save_settings();
		break;
		
		case "fnafanimatronics":
			//show_debug_message("Animatronic Stuff");
			update_game_settings(game_settings.volume_enabled, game_settings.last_location, undefined, _value, undefined);
			//var _array = tag_get_asset_ids("Animatronic", asset_sound);
			/*for(var _i = 0; _i < array_length(_array); ++_i) {
				if (audio_is_playing(_i)) {
					audio_sound_gain(_i, _value, 0);	
				}
			}*/
			
			save_settings();
		break;
		
		case "freddyai":
			obj_cams.game_settings.freddyAI = _value;
			save_settings();
		break;
		
		case "foxyai":
			obj_cams.game_settings.foxyAI = _value;
			save_settings();
		break;
		
		case "chicaai":
			obj_cams.game_settings.chicaAI = _value;
			save_settings();
		break;
		
		case "bonnieai":
			obj_cams.game_settings.bonnieAI = _value;
			save_settings();
		break;
		
		case "fnafgarblecamera":
			obj_cams.game_settings.garbledCamera = _value;
			save_settings();
		break;
		
		case "fnafisfirstdaysunday":
			obj_cams.game_settings.isFirstDaySunday = _value;
			save_settings();
		break;
		
		case "fnafcamerashuffle":
			obj_cams.game_settings.cameraShuffle = _value;
			save_settings();
		break;
		
		case "fnafflashalpha":
			obj_cams.game_settings.flashAlpha = _value;
			save_settings();
		break;
		
		case "fnafstaticalpha":
			obj_cams.game_settings.staticAlpha = _value;
			save_settings();
		break;
		
		case "fnaflightflicker":
			obj_cams.game_settings.lightFlicker = _value;
			save_settings();
		break;
		
		default:
			show_debug_message("Unknown property " + _keyName + "! Please let the developer know!");
		break;
	}
}