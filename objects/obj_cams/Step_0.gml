/// @description Cat Judges your code
/* 
    |\__/,|   (`\
  _.|o o  |_   ) )
-(((---(((--------
Cat Judges your code
*/
/// mouse camera movement

/*if (randomMoveTimer > 0) {
	--randomMoveTimer;	
}

if (randomMoveTimer == 0) {
	var _char = irandom(characters.Length-1);
	switch(_char) {
		case characters.Freddy:
			if (animatronics.Bonnie.location == locations.Stage) {
				if (animatronics.Chica.location == locations.Stage) {	
					moveAnimatronic(choose(animatronics.Bonnie,animatronics.Chica));	
				} else {
					moveAnimatronic(animatronics.Chica);		
				}
			} else if (animatronics.Chica.location == locations.Stage) {	
				moveAnimatronic(animatronics.Chica);
			}	
		break;
	}
	
	randomMoveTimer = 10*60;
}*/

//var _map = audio_get_listener_info(0);

//show_debug_message(json_encode(_map));

//ds_map_destroy(_map);

/*var _masterAudioPitch = audio_get_master_gain(0);

if !window_has_focus() {
	if game_settings.volume_enabled {
		audio_master_gain(lerp(_masterAudioPitch,0,.05));	
	} 
} else {
	if game_settings.volume_enabled {
		audio_master_gain(lerp(_masterAudioPitch,1,.05));	
	}
}*/

/*if (os_type == os_windows) && (os_browser == browser_not_a_browser) {
	window_frame_update();	
}*/

if (randomHallucinations > 0) && (--randomHallucinationsNumTimer <= 0) {
	randomHallucinationsNumTimer = 5;
	randomHallucinationsNum = irandom(sprite_get_number(spr_hallucinations));
}

if (randomHallucinations > 0) {
	--randomHallucinations;	
	if !(audio_is_playing(snd_hallucinations)) {
		var _index = audio_play_sound(snd_hallucinations, 100, false);
		audio_sound_gain(_index, obj_cams.game_settings.volume_animatronics, 0);
		global.currentAudio.hallucinations = _index;
	}
} else if (irandom(10000) == 0) {
	randomHallucinations = irandom_range(1,4)*60;	
}

if (randomHallucinations <= 0) {
	if (audio_is_playing(global.currentAudio.hallucinations)) {
		audio_stop_sound(snd_hallucinations);
	}
}

if (global.animatronicsHaveMoved) && (irandom(100000) == 0) {
	if !(audio_is_playing(snd_eerieAmbience)) {
		var _index = audio_play_sound(snd_eerieAmbience, 100, false);
		audio_sound_gain(_index, obj_cams.game_settings.volume_ambient, 0);
		global.currentAudio.eerieAmbience = _index;
	}
}

if (global.animatronicsHaveMoved == false) {
	if !(audio_is_playing(snd_ambienceSilent)) {
		var _index = audio_play_sound(snd_ambienceSilent, 100, false);
		audio_sound_gain(_index, obj_cams.game_settings.volume_ambient, 0);
		global.currentAudio.eerieAmbience = _index;
	}	
} else {
	if (audio_is_playing(snd_ambienceSilent)) {
		audio_stop_sound(snd_ambienceSilent);
	}
	
	if !(audio_is_playing(snd_ambienceGeneral)) {
		var _index = audio_play_sound(snd_ambienceGeneral, 20, false);
		audio_sound_gain(_index, obj_cams.game_settings.volume_ambient, 0);
		global.currentAudio.eerieAmbience = _index;	
	}
}

if (global.animatronicsIsMoving > 0) {
		if !(audio_is_playing(global.currentAudio.garbled)) {
			var _name = "snd_garble" + string(irandom_range(1,3));
			var _index = audio_play_sound(asset_get_index(_name), 0, false);
			audio_sound_gain(_index, obj_cams.game_settings.volume_ui, 0);
			global.currentAudio.garbled = _index;	
		}
		--global.animatronicsIsMoving;
} else {
	if (audio_is_playing(global.currentAudio.garbled)) {
		audio_stop_sound(global.currentAudio.garbled);	
	}
}

if (static_timer == 0) {
	if (currentCamera.location == locations.HallwayLeftB) && (backIndex == 0) {
		if (device_mouse_check_button_pressed(0, mb_left)) {
			if (point_in_circle(device_mouse_x(0), device_mouse_y(0), 658, 166, 12))	 {
				//if !audio_is_playing(snd_freddynose) {
					var _index = audio_play_sound(snd_freddynose, 0, false);
					audio_sound_gain(_index, .3*game_settings.volume_ui, 0);
					global.currentAudio.blipClick = _index;
				//}
			}	
		}
	} else if (currentCamera.location == locations.HallwayLeftB) && (backIndex == 2) {
		if (device_mouse_check_button_pressed(0, mb_left)) {
			if (point_in_circle(device_mouse_x(0), device_mouse_y(0), 658, 232, 16))	 {
				//if !audio_is_playing(snd_freddynose) {
					var _index = audio_play_sound(snd_error, 0, false);
					audio_sound_gain(_index, .3*game_settings.volume_ui, 0);
					global.currentAudio.blipClick = _index;
				//}
			}	
		}
	}
	
	if (cameraChange) {
		cameraChangeIndex += image_speed_get(spr_vhs_change);
		if (cameraChangeIndex > sprite_get_number(spr_vhs_change)) {
			cameraChange = false;
			cameraChangeIndex = 0;
		}
	}
	
	if (global.width != browser_width) || (global.height != browser_height) {
		surface_resize(application_surface,browser_width, browser_height);
		window_set_size(browser_width, browser_height);
		rescaleCanvas();
		
		global.width = browser_width;
		global.height = browser_height;
	}
	
	if audio_sound_is_playable(Buzz_Fan_Florescent2) {
		if !audio_is_playing(Buzz_Fan_Florescent2) {
			var _index = audio_play_sound(Buzz_Fan_Florescent2, 0, false);
			audio_sound_gain(_index, .3*game_settings.volume_ambient, 0);
			global.currentAudio.buzzFan = _index;
		}
	}
	
	if audio_sound_is_playable(MiniDV_Tape_Eject_1) {
		if !audio_is_playing(MiniDV_Tape_Eject_1) {
			var _index = audio_play_sound(MiniDV_Tape_Eject_1, 0, false);
			audio_sound_gain(_index, game_settings.volume_ui, 0);
			global.currentAudio.VCRSFX = _index;
		}
	}
	
	// Animatronic moving
	#region Foxy goes first
	if (irandom(6000  * (1.1 - (game_settings.foxyAI - 9))) == 0) {
		if (currentCamera.location != locations.PirateCove) {
			if (animatronics.Foxy.foxyStage != 3) && !(visitedFoxyRun) {
				++animatronics.Foxy.foxyStage;	
			} 
		}
	}
	
	if (currentCamera.location == locations.HallwayLeftA) {
		if (animatronics.Foxy.foxyStage == 3) && (foxyAnimateRun < sprite_get_number(spr_foxy_run)-1) && (visitedFoxyRun) {
			foxyAnimateRun += image_speed_get(spr_foxy_run);
			backIndex = foxyAnimateRun;	
			if !(audio_is_playing(snd_run)) {
				var _index = audio_play_sound(snd_run,0, false);	
				audio_sound_gain(_index, .6*game_settings.volume_animatronics, 0);
				global.currentAudio.foxyRunning = _index;
			}
		} 
	} else {
		if (animatronics.Foxy.foxyStage == 3) {
			if (irandom(2000) == 0) {
				if !audio_is_playing(snd_knock2) {
					var _index = audio_play_sound(snd_knock2, 0, false);	
					audio_sound_gain(_index, game_settings.volume_animatronics, 0);
					global.currentAudio.knocking = _index;
				}	
				resetFoxy();
				if (currentCamera.location == locations.PirateCove) {
					cameraChangeFlicker();
					animatronicMovedChange();
					sceneSwitch();
				}
			}
		}
	}
	
	if (foxyAnimateRun == sprite_get_number(spr_foxy_run)-1) {
		resetFoxy();
		if (animatronics.Bonnie.location == locations.HallwayLeftA) {
				backIndex = 1;
			} else {
				backIndex = 0;	
			}
		if !audio_is_playing(snd_knock2) {
			var _index = audio_play_sound(snd_knock2, 0, false);	
			audio_sound_gain(_index, game_settings.volume_animatronics, 0);
			global.currentAudio.knocking = _index;
		}
	}
	
	// Foxy singing Timer
	if (irandom(4800) == 0) {
		if (animatronics.Foxy.foxyStage == 0) {
			if !(audio_is_playing(snd_pirate_song)) {
				var _index = audio_play_sound(snd_pirate_song, 0, false);
				global.currentAudio.pirateSong = _index;
				audioSwitchPirate();
			}
		}
	}
	#endregion
	
	#region Bonnie/Chica/Freddy Move
		if (irandom(1800 * (1.1 - (game_settings.bonnieAI - 9))) == 0) {
			moveAnimatronic(animatronics.Bonnie);
		}
		
		if (irandom(1600 * (1.1 - (game_settings.chicaAI - 9))) == 0) {
			moveAnimatronic(animatronics.Chica);
		}
		
		if (irandom(2400 * (1.1 - (game_settings.freddyAI - 9))) == 0) {
			moveAnimatronic(animatronics.Freddy);	
		}
		
		if (animatronics.Chica.location == locations.Kitchen) {
			if (irandom(120) == 0) {
				if !(audio_is_playing(snd_OVEN_DRA_1_GEN_HDF18119) || audio_is_playing(snd_OVEN_DRA_2_GEN_HDF18120)	 || audio_is_playing(snd_OVEN_DRA_7_GEN_HDF18121) || audio_is_playing(snd_OVEN_DRAWE_GEN_HDF18122)) {
					var _index = audio_play_sound(choose(snd_OVEN_DRA_1_GEN_HDF18119, snd_OVEN_DRA_2_GEN_HDF18120, snd_OVEN_DRA_7_GEN_HDF18121, snd_OVEN_DRAWE_GEN_HDF18122), 0, false);
					global.currentAudio.kitchenPans = _index;
					audioSwitchKitchen();
				}
		} 
			
			if (irandom(1200) == 0) {
				if !(audio_is_playing(snd_music_box) || audio_is_playing(snd_circius)) {
					var _index = audio_play_sound(snd_circius, 0, false);
					global.currentAudio.kitchenSong = _index;
					audioSwitchKitchen();
				}
			}
		} else {
				audio_stop_sounds(snd_OVEN_DRA_1_GEN_HDF18119, snd_OVEN_DRA_2_GEN_HDF18120, snd_OVEN_DRA_7_GEN_HDF18121, snd_OVEN_DRAWE_GEN_HDF18122, snd_circius);	
		}
		
		if (animatronics.Freddy.location == locations.Kitchen) {
			if (irandom(2400) == 0) {
				if !(audio_is_playing(snd_music_box) || audio_is_playing(snd_circius)) {
					var _index = audio_play_sound(snd_music_box, 0, false);
					global.currentAudio.kitchenSong = _index;
					audioSwitchKitchen();
				}
			}	
		} else {
			audio_stop_sound(snd_music_box);	
		}
		
		
	#endregion
	
	// move the view when mouse reaches the edge.
	if (!halt) {
		#macro INCR .8
		
		//view_xview[0] = lerp(view_xview[0], clamp(abs(sin(current_time / 5000)*(view_wview[0]/5)),0, room_width-(view_wview[0]/12)), .25);
		var _view = view_camera[0];
		var _xview = camera_get_view_x(_view);
		var _wview = camera_get_view_width(_view);
		
		if (flip) {
				if (_xview < (room_width-_wview)) {camera_set_view_pos(_view, _xview+INCR, 0);} else {flip = false; halt = true; alarm[0] = 60;}
			} else {
			    if (_xview > 0) {camera_set_view_pos(_view, _xview-INCR, 0);} else {flip = true; halt = true; alarm[0] = 60;}
			}
		}
} else {
	--static_timer;	
}
//window_set_fullscreen(true);*/