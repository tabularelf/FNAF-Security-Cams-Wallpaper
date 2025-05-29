function audioSwitchPirate() {
	var game_settings = global.game_settings;
	switch(obj_cams.currentCamera.location) {
		case locations.PirateCove:
			audio_sound_gain(snd_pirate_song,.6*game_settings.volume_animatronics,0);	
		break;
		
		case locations.PartyRoom:
		case locations.Backstage:
			audio_sound_gain(snd_pirate_song,.4*game_settings.volume_animatronics,0);	
		break;
		
		case locations.Stage:
		case locations.HallwayLeftA:
		case locations.Closet:
			audio_sound_gain(snd_pirate_song,.1*game_settings.volume_animatronics,0);	
		break;
		
		default:
			audio_sound_gain(snd_pirate_song,.05*game_settings.volume_animatronics,0);	
		break;
	}	
}

function audioSwitchKitchen() {
	
	var _audioOven = -1;
	var _audioMusic = -1;
	
	// Moving kitchen
	/*if (audio_is_playing(snd_OVEN_DRA_1_GEN_HDF18119)) {
		_audioOven = snd_OVEN_DRA_1_GEN_HDF18119;	
	} else if (audio_is_playing(snd_OVEN_DRAWE_GEN_HDF18122)) {
		_audioOven = snd_OVEN_DRAWE_GEN_HDF18122;	
	} else if (audio_is_playing(snd_OVEN_DRA_2_GEN_HDF18120)) {
		_audioOven = snd_OVEN_DRA_2_GEN_HDF18120;	
	} else if (audio_is_playing(snd_OVEN_DRA_7_GEN_HDF18121)) {
		_audioOven = snd_OVEN_DRA_7_GEN_HDF18121;	
	}*/
	
	if (audio_is_playing(global.currentAudio.kitchenPans)) {
		_audioOven = global.currentAudio.kitchenPans;
	}
	
	if (audio_is_playing(global.currentAudio.kitchenSong)) {
		_audioMusic = global.currentAudio.kitchenSong;	
	} else if (audio_is_playing(global.currentAudio.kitchenSong)) {
		_audioMusic = global.currentAudio.kitchenSong;	
	}
	
	if (audio_exists(_audioOven)) {
		switch(currentCamera.location) {
			case locations.Kitchen:
				audio_sound_gain(_audioOven,.4*game_settings.volume_ambient,0);	
			break;
			
			case locations.HallwayRightA:
			case locations.Restrooms:
				audio_sound_gain(_audioOven,.3*game_settings.volume_ambient,0);	
			break;
			
			case locations.HallwayRightB:
				audio_sound_gain(_audioOven,.1*game_settings.volume_ambient,0);	
			break;
			
			default:
				audio_sound_gain(_audioOven,0*game_settings.volume_ambient,0);	
			break;
		}	
	}
	
	if (audio_exists(_audioMusic)) {
		switch(currentCamera.location) {
			case locations.Kitchen:
				audio_sound_gain(_audioMusic,.5*game_settings.volume_animatronics,0);	
			break;
			
			case locations.HallwayRightA:
			case locations.Restrooms:
				audio_sound_gain(_audioMusic,.3*game_settings.volume_animatronics,0);	
			break;
			
			case locations.HallwayRightB:
				audio_sound_gain(_audioMusic,.1*game_settings.volume_animatronics,0);	
			break;
			
			default:
				audio_sound_gain(_audioMusic,.05*game_settings.volume_animatronics,0);	
			break;
		}	
	}
}

global.animatronicsIsMoving = 0;
function animatronicMovedChange() {
	if (obj_cams.game_settings.garbledCamera) && (global.animatronicsIsMoving <= 0) {
		global.animatronicsIsMoving = irandom_range(2, 5)*60;	
	}
}