/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

// Render static
draw_sprite_ext(spr_static,	current_time*image_speed_get(spr_static), 0, 0, 1, 1, 0, c_white, .15);

if (cameraChange) {
	draw_sprite(spr_vhs_change,	cameraChangeIndex,0, 0);	
}
	
// Render UI
// Site map
draw_sprite(spr_cam_border, 0, 0, 0);
draw_sprite(spr_site_map,0,864,320);

// Power/Usage Words
draw_sprite(spr_power_left, 0, 32, 652);
draw_sprite(spr_num_9, 0, 176, 644);
draw_sprite(spr_num_0, 0, 196 , 644);
draw_sprite(spr_percent, 0, 220 , 652);


draw_sprite(spr_power_usage_sign, 0, 32, 680);
draw_sprite(spr_power_usage, 0,112, 672);

draw_sprite(spr_num_2, 0,1172, 34);
draw_sprite(spr_am, 0,1204, 36);
draw_sprite(spr_night, 0,1168, 68);	
draw_sprite(spr_num_3, 0,1236, 68);

// Rest of UI

// Camera Button
draw_sprite(spr_camera_down,0, 544, 700);

#region settings UI
var _settingX = 32, _settingY = 32, _settingSprite = spr_gear;
	var _settingAlpha = 0;
	// Mute button posit
	if point_in_rectangle(_mx, _my, _settingX, _settingY, _settingX+sprite_get_width(_settingSprite), _settingY+sprite_get_height(_settingSprite)) {
		_settingAlpha = 1;
		if device_mouse_check_button_released(0, mb_left) {
			settingsUIEnabled = !settingsUIEnabled;
		}
	} 
	
	draw_sprite_ext(_settingSprite,	current_time*image_speed_get(spr_static), _settingX, _settingY, 1, 1, 0, c_white, _settingAlpha);
	
if (settingsUIEnabled) {
	
	// Draw UI
	draw_sprite_ext(spr_ui, 0, 456, 196, 19.42532, 21.247, 0, c_white, 1);
	
	// Temp slider
	var _sliderLeftX = 660, _sliderRightX = 764, _sliderButtonY = 240, _sliderButtonYIncr = 44, _sliderButtonWidth = 32; 
	var _sliderLeftXFix = _sliderLeftX-16, _sliderRightXFix = _sliderRightX-16, _sliderButtonYFix = _sliderButtonY-16;
	
	// Left Side
	draw_sprite_ext(spr_arrow, 0, _sliderLeftX, _sliderButtonY,					       1, 1, 180, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderLeftX, _sliderButtonY + (_sliderButtonYIncr*1), 1, 1, 180, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderLeftX, _sliderButtonY + (_sliderButtonYIncr*2), 1, 1, 180, c_white, 1);
	
	// Right Side			   	  
	draw_sprite_ext(spr_arrow, 0, _sliderRightX, _sliderButtonY,							1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderRightX, _sliderButtonY + (_sliderButtonYIncr*1), 1, 1, 0, c_white, 1);
	draw_sprite_ext(spr_arrow, 0, _sliderRightX, _sliderButtonY + (_sliderButtonYIncr*2), 1, 1, 0, c_white, 1);
	
	// UI Text
	draw_text(_sliderLeftX-160, _sliderButtonY, "Ambience");
	draw_text(_sliderLeftX-160, _sliderButtonY + (_sliderButtonYIncr*1), "Animatronics");
	draw_text(_sliderLeftX-160, _sliderButtonY + (_sliderButtonYIncr*2), "UI");
	
	// Text Boxes
	draw_set_valign(fa_center);
	draw_sprite_ext(spr_ui, 0, 680, 224, 3.666667, 2.066667, 0, c_white, 1);
	draw_sprite_ext(spr_ui, 0, 680, 268, 3.666667, 2.066667, 0, c_white, 1);
	draw_sprite_ext(spr_ui, 0, 680, 312, 3.666667, 2.066667, 0, c_white, 1);
	
	// Text
	var _c = c_black;
	draw_text_colour(680+7, 224+14, string(clamp(round(game_settings.volume_ambient * 100), 0, 100)) + "%",		_c, _c, _c, _c, 1);
	draw_text_colour(680+7, 268+14, string(clamp(round(game_settings.volume_animatronics * 100), 0, 100)) + "%",	_c, _c, _c, _c, 1);
	draw_text_colour(680+7, 312+14, string(clamp(round(game_settings.volume_ui * 100), 0, 100)) + "%",			_c, _c, _c, _c, 1);
	
	
	if (arrowSelected) {
		if (arrowTimer > 0) {
			arrowTimer--;	
		}
	}
	
	// Buttons
	var _incr = .01;
	var _oldAmbient = game_settings.volume_ambient, _oldAnimatronic = game_settings.volume_animatronics, _oldUI = game_settings.volume_ui;
	
	// Ambient
	if (point_in_rectangle(_mx, _my, _sliderLeftXFix, _sliderButtonYFix, _sliderLeftXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth)) {
		//show_debug_message("E Left");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAmbient -= _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAmbient -= _incr;
			}
		} else arrowSelected = false;	
	}
	
	if (point_in_rectangle(_mx, _my, _sliderRightXFix, _sliderButtonYFix, _sliderRightXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth)) {
		//show_debug_message("E Right");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAmbient += _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAmbient += _incr;
			}
		} else arrowSelected = false;	
	}
	
	// Animatronics
	if (point_in_rectangle(_mx, _my, _sliderLeftXFix, _sliderButtonYFix + (_sliderButtonYIncr*1), _sliderLeftXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*1))) {
		//show_debug_message("A Left");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAnimatronic -= _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAnimatronic -= _incr;
			}
		} else arrowSelected = false;	
	}

	if (point_in_rectangle(_mx, _my, _sliderRightXFix - 16, _sliderButtonYFix + (_sliderButtonYIncr*1), _sliderRightXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*1))) {
		//show_debug_message("A Right");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldAnimatronic += _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldAnimatronic += _incr;
			}
		} else arrowSelected = false;	
	}
	
		// Ui
	if (point_in_rectangle(_mx, _my, _sliderLeftXFix, _sliderButtonYFix + (_sliderButtonYIncr*2), _sliderLeftXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*2))) {
		//show_debug_message("Games Left");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldUI -= _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldUI -= _incr;
			}
		} else arrowSelected = false;	
	}
	
	if (point_in_rectangle(_mx, _my, _sliderRightXFix, _sliderButtonYFix + (_sliderButtonYIncr*2), _sliderRightXFix + _sliderButtonWidth, _sliderButtonYFix + _sliderButtonWidth + (_sliderButtonYIncr*2))) {
		//show_debug_message("Games Right");
		if device_mouse_check_button(0, mb_left) {
			if !(arrowSelected) {
				arrowSelected = true;
				arrowTimer = 10;
				_oldUI += _incr;
			} else if (arrowTimer <= 0) {
				arrowTimer = 10;	
				_oldUI += _incr;
			}
		} else arrowSelected = false;
	}
	
	// Clamp Volume
	_oldAmbient = clamp(_oldAmbient,0, 100);
	_oldAnimatronic = clamp(_oldAnimatronic,0, 100);
	_oldUI = clamp(_oldUI,0, 100);
	
	if (_oldAmbient != game_settings.volume_ambient || _oldAnimatronic != game_settings.volume_animatronics || _oldUI != game_settings.volume_ui) {
		update_game_settings(game_settings.volume_enabled, game_settings.last_location, _oldAmbient, _oldAnimatronic, _oldUI);
		save_settings();
		
		// Loop between all
		var _array = tag_get_asset_ids("Ambient", asset_sound);
		show_debug_message(_array);
		for(var _i = 0; _i < array_length(_array); ++_i) {
			if (audio_is_playing(_i)) {
				audio_sound_gain(_i, _oldAmbient, 0);	
			}
		}
		
		var _array = tag_get_asset_ids("UI", asset_sound);
		show_debug_message(_array);
		for(var _i = 0; _i < array_length(_array); ++_i) {
			if (audio_is_playing(_i)) {
				audio_sound_gain(_i, _oldUI, 0);	
			}
		}
		var _array = tag_get_asset_ids("Animatronic", asset_sound);
		show_debug_message(_array);
		for(var _i = 0; _i < array_length(_array); ++_i) {
			if (audio_is_playing(_i)) {
				audio_sound_gain(_i, _oldAnimatronic, 0);	
			}
		}
		
		audioSwitchKitchen();
		audioSwitchPirate();
	}	
	#region old Slider Code Don't use
	/*// Draw Sliders
	var _sliderSprite = spr_ui, _sliderX = 558, _sliderY1 = 228, _sliderY2 = 276, _sliderY3 = 316;
	draw_sprite_ext(_sliderSprite, 0, _sliderX, _sliderY1, 11.66667, 1, 0, c_white, 1);
	draw_sprite_ext(_sliderSprite, 0, _sliderX, _sliderY2, 11.66667, 1, 0, c_white, 1);
	draw_sprite_ext(_sliderSprite, 0, _sliderX, _sliderY3, 11.66667, 1, 0, c_white, 1);
	
	// Draw Slider Knob
	
	var _knobSprite = spr_knob, _knobX = 558, _knobY1 = 236, _knobY2 = 280, _knobY3 = 324;
	
	// This is not how you do slider stuff btw. This is really dumb. Don't do this.
	var _sliderPadding = .69; // Haha funny sex number
	var _sliderMaxPadding = 1.36;
	
	// We'll get the knox pos
	var _knobX1 = _knobX * (game_settings.volume_ambient + _sliderPadding),
		_knobX2 = _knobX * (game_settings.volume_animatronics + _sliderPadding),
		_knobX3 = _knobX * (game_settings.volume_ui + _sliderPadding);
		
		_knobX1 = clamp(_knobX1, _knobX, _knobX * _sliderMaxPadding);
	
	if !(knob1Selected) draw_sprite_ext(_knobSprite, 0, _knobX1, _knobY1, 1, 1, 0, c_white, 1);
	draw_sprite_ext(_knobSprite, 0, _knobX2, _knobY2, 1, 1, 0, c_white, 1);
	draw_sprite_ext(_knobSprite, 0, _knobX3, _knobY3, 1, 1, 0, c_white, 1);
	
	var _knobOffset = sprite_get_xoffset(_knobSprite);
	
	if point_in_rectangle(_mx, _my, _knobX1-_knobOffset, _knobY1-_knobOffset, _knobX1-_knobOffset+sprite_get_width(_knobSprite), _knobY1-_knobOffset+sprite_get_height(_knobSprite)) || (knob1Selected) {
		if (device_mouse_check_button(0, mb_left)) {
			knob1Selected = true;	
		} else {
			knob1Selected = false;	
		}
		
		if (knob1Selected) {
			var _ClampKnobX1 = clamp(_mx, _knobX, _knobX * _sliderMaxPadding);
			draw_sprite(spr_knob,0,_ClampKnobX1,_knobY1);
			update_game_settings(game_settings.volume_enabled, game_settings.last_location, normalize(_knobX, _knobX * _sliderMaxPadding, _ClampKnobX1));
		}
	}*/
	#endregion
	
	// Draw Mute Button
	var _muteX = 464, _muteY = 476, _muteSprite = spr_mute_call;
	draw_sprite_ext(_muteSprite,	current_time, _muteX, _muteY, 1, 1, 0, c_white, 1);
	if point_in_rectangle(_mx, _my, _muteX, _muteY, _muteX+sprite_get_width(_muteSprite), _muteY+sprite_get_height(_muteSprite))  && device_mouse_check_button_released(0, mb_left) {
		audio_set_master_gain(0, !audio_get_master_gain(0));	
		update_game_settings(audio_get_master_gain(0), currentCamera.location_name);
		save_settings();
	}
}
#endregion 
// Camera Buttons
for(var _i = 0; _i < array_length(cams); ++_i) {
	var _cam = cams[_i];
	if _cam.selected {
		if (--_cam.selectedVisualTimer) <= 0 {
			_cam.selectedVisualTimer = 30;
			_cam.selectedVisual = !_cam.selectedVisual;
		}
	}
	
	if (_cam.point_in_rect()) {
			if device_mouse_check_button_released(0, mb_left) {
				if audio_sound_is_playable(blip3) {
					if !audio_is_playing(blip3) {
						var _index = audio_play_sound(blip3, 0, false);
						audio_sound_gain(_index, game_settings.volume_ui, 0);
				}
			}
			if(currentCamera != _cam) {
				cameraChangeFlicker();
				currentCamera = _cam;
				backSprite = _cam.scene;
				sceneSwitch();
				update_game_settings(audio_get_master_gain(0), currentCamera.location_name);
				save_settings();
			}
			
			if (_cam.randomAudioChange != -1) {
				if (irandom(1000) == 0) {
					var _index = audio_play_sound(_cam.randomAudioChange, 0, false);	
					audio_sound_gain(_index, .6*game_settings.volume_ui, 0);
				}
			}
			for(var _ii = 0; _ii < array_length(cams); ++_ii) {
				cams[_ii].selected = false;	
			}
			
			_cam.selected = true;
		}
	}
	
	_cam.render();
}

/*draw_text(32,32,animatronics.Foxy);
draw_text(32,64,foxyAnimateRun);
draw_text(32,96,visitedFoxyRun);*/

//draw_circle(_mx, _my, 32, false);