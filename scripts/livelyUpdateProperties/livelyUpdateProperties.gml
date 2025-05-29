function livelyUpdateProperties(_name, _value) {
	__init_settings();
	var game_settings = global.game_settings;
	switch(_name) {
		case "fnafmuteaudio": 
			//show_debug_message("Audio Mute Stuff");
			audio_set_master_gain(0, !_value);	
			show_debug_message("This shouldn't be the problem, right?");
			update_game_settings(!_value, game_settings.last_location);
		break;
		
		case "fnafambience":
			//show_debug_message("Ambience Stuff");
			update_game_settings(game_settings.volume_enabled, game_settings.last_location, _value, undefined, undefined);
			/*var _array = tag_get_asset_ids("Ambient", asset_sound);
			for(var _i = 0; _i < array_length(_array); ++_i) {
				if (audio_is_playing(_i)) {
					audio_sound_gain(_i, _value, 0);	
				}
			}*/
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
			
		break;
		
		case "freddyai":
			//show_debug_message("AI time!");
			game_settings.freddyAI = _value;
		break;
		
		case "foxyai":
			//show_debug_message("AI time!");
			game_settings.foxyAI = _value;
		break;
		
		case "chicaai":
			//show_debug_message("AI time!");
			game_settings.chicaAI = _value;
		break;
		
		case "bonnieai":
			//show_debug_message("AI time!");
			game_settings.bonnieAI = _value;
		break;
		
		case "fnafgarblecamera":
			//show_debug_message("Misc!");
			game_settings.garbledCamera = _value;
		break;
		
		case "fnafisfirstdaysunday":
			//show_debug_message("Misc!");
			game_settings.isFirstDaySunday = _value;
		break;
		
		case "fnafcamerashuffle":
			//show_debug_message("Misc!");
			game_settings.cameraShuffle = _value;
		break;
		
		case "fnafflashalpha":
			//show_debug_message("Misc!");
			game_settings.flashAlpha = _value;
		break;
		
		case "fnafstaticalpha":
			//show_debug_message("Misc!");
			game_settings.staticAlpha = _value;
		break;
		
		case "fnaflightflicker":
			//show_debug_message("Misc!");
			game_settings.lightFlicker = _value;
		break;
		
		default:
			show_debug_message("Unknown property " + _name + "! Please let the developer know!");
		break;
	}
}