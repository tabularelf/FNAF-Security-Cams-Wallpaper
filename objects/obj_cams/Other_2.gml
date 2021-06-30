/// @description Has to be in here because GameMaker is dumb sometimes

function cameraChangeFlicker() {
	cameraChange = true;
	cameraChangeIndex = 0;	
}

function staticChange() {
	static_timer = irandom_range(static_timer_min, static_timer_max);	
	cameraChangeFlicker();
}

function resetFoxy() {
	visitedFoxyRun = false;
	animatronics.Foxy.foxyStage = 0;	
	foxyAnimateRun = 0;
	backSprite = currentCamera.scene;
}

function audioSwitchPirate() {
	switch(currentCamera.location) {
		case locations.PirateCove:
			audio_sound_gain(snd_pirate_song,.6*game_settings.volume_ambient,0);	
		break;
		
		case locations.PartyRoom:
		case locations.Backstage:
			audio_sound_gain(snd_pirate_song,.4*game_settings.volume_ambient,0);	
		break;
		
		case locations.Stage:
		case locations.HallwayLeftA:
		case locations.Closet:
			audio_sound_gain(snd_pirate_song,.1*game_settings.volume_ambient,0);	
		break;
		
		default:
			audio_sound_gain(snd_pirate_song,.05*game_settings.volume_ambient,0);	
		break;
	}	
}

function audioSwitchKitchen() {
	
	var _audioOven = -1;
	var _audioMusic = -1;
	
	// Moving kitchen
	if (audio_is_playing(snd_OVEN_DRA_1_GEN_HDF18119)) {
		_audioOven = snd_OVEN_DRA_1_GEN_HDF18119;	
	} else if (audio_is_playing(snd_OVEN_DRAWE_GEN_HDF18122)) {
		_audioOven = snd_OVEN_DRAWE_GEN_HDF18122;	
	} else if (audio_is_playing(snd_OVEN_DRA_2_GEN_HDF18120)) {
		_audioOven = snd_OVEN_DRA_2_GEN_HDF18120;	
	} else if (audio_is_playing(snd_OVEN_DRA_7_GEN_HDF18121)) {
		_audioOven = snd_OVEN_DRA_7_GEN_HDF18121;	
	}
	
	if (audio_is_playing(snd_circius)) {
		_audioMusic = snd_circius;	
	} else if (audio_is_playing(snd_music_box)) {
		_audioMusic = snd_music_box;	
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
				audio_sound_gain(_audioMusic,.5*game_settings.volume_ambient,0);	
			break;
			
			case locations.HallwayRightA:
			case locations.Restrooms:
				audio_sound_gain(_audioMusic,.3*game_settings.volume_ambient,0);	
			break;
			
			case locations.HallwayRightB:
				audio_sound_gain(_audioMusic,.1*game_settings.volume_ambient,0);	
			break;
			
			default:
				audio_sound_gain(_audioMusic,.05*game_settings.volume_ambient,0);	
			break;
		}	
	}
}


function sceneSwitch() {
	
	if (visitedFoxyRun) {	
		if !audio_is_playing(snd_knock2) && animatronics.Foxy.foxyStage == 3 {
			var _index = audio_play_sound(snd_knock2, 0, false);	
			audio_sound_gain(_index, game_settings.volume_animatronics, 0);
		}
		
		resetFoxy();
		backSprite = currentCamera.scene;
		
		if audio_is_playing(snd_run)  {
			audio_stop_sound(snd_run);
		}
	}
	
	backIndex = 0;
	audioSwitchKitchen();
	audioSwitchPirate();
	
	switch(currentCamera.location) {
		case locations.Stage:
			backIndex = 6;
			
			if (animatronics.Bonnie.location == locations.Stage && animatronics.Chica.location == locations.Stage && animatronics.Freddy.location == locations.Stage) {
				backIndex = choose(0,0,0,0,1);
			} else if (animatronics.Bonnie.location != locations.Stage && animatronics.Chica.location == locations.Stage) {
				backIndex = 3;	
			} else if (animatronics.Bonnie.location == locations.Stage && animatronics.Chica.location != locations.Stage) {
				backIndex = 2;	
			} else if (animatronics.Freddy.location == locations.Stage) {
				backIndex = choose(4,4,4,5,5);	
			}
		break;
		
		case locations.PartyRoom:
			backIndex = 0;
			
			if (animatronics.Chica.location == locations.PartyRoom) {
				backIndex = 3 + animatronics.Chica.subPos;
			} else if (animatronics.Bonnie.location == locations.PartyRoom) {
				backIndex = 1 + animatronics.Bonnie.subPos;
			} else if (animatronics.Freddy.location == locations.PartyRoom) {
				backIndex = 5;
			}
		break;
		
		case locations.Restrooms:
			backIndex = 0;
			
			if (animatronics.Chica.location == locations.Restrooms) {
				backIndex = 1 + animatronics.Chica.subPos;
			} else if (animatronics.Freddy.location == locations.Restrooms) {
				backIndex = 3;
			}
		break;
		
		case locations.HallwayRightA:
			backIndex = 0;
			
			if (animatronics.Chica.location == locations.HallwayRightA) {
				backIndex = 1 + animatronics.Chica.subPos;
			} else if (animatronics.Freddy.location == locations.HallwayRightA) {
				backIndex = 3;
			}
		break;
		
		case locations.HallwayRightB:
			backIndex = irandom(3);
			
			if (animatronics.Chica.location == locations.HallwayRightB) {
				backIndex = choose(4, 4, 4, 5);
			} else if (animatronics.Freddy.location == locations.HallwayRightB) {
				backIndex = 6;
			}
		break;
		
		case locations.PirateCove: 
			backIndex = animatronics.Foxy.foxyStage;
		break;
		
		case locations.Backstage: 
			if (animatronics.Bonnie.location == locations.Backstage) {
				backIndex = choose(2, 2, 2, 2, 3);	
			} else {
				backIndex = choose(0, 0, 0, 1);	
			}
		break;
		
		case locations.HallwayLeftA:
			if (animatronics.Foxy.foxyStage == 3) && !(visitedFoxyRun) {
				foxyAnimateRun = 0;
				visitedFoxyRun = true;
				backSprite = spr_foxy_run;
				cameraChangeFlicker();
			} else if (animatronics.Bonnie.location == locations.HallwayLeftA) {
				backIndex = 1;
			} else {
				backIndex = 0;	
			}
		break;
		
		case locations.Closet:
			if (animatronics.Bonnie.location == locations.Closet) {
				backIndex = 1;
			} else {
				backIndex = 0;	
			}
		break;
		
		case locations.HallwayLeftB:
			if (animatronics.Bonnie.location == locations.HallwayLeftB) {
				backIndex = choose(2, 2, 2, 3, 3, 4);
			} else {
				backIndex = choose(0,0,0,0,0,0,0,0,1);	
			}
		break;
		
		default: 
			backIndex = 0;
		break;
	}
}

foxyAnimateRun = 0;
visitedFoxyRun = false;
 
 // Camera creation
 var _i = 0;
cams[10] = 0;
cams[0] = new cam_create(locations.Stage, 968, 344, 991, 363, spr_cam_1a, spr_stage,					spr_cam_show_stage);
cams[1] = new cam_create(locations.PartyRoom, 944, 396, 968, 416, spr_cam_1b, spr_party_room,			spr_cam_dining_area);
cams[2] = new cam_create(locations.PirateCove, 912, 476, 936, 496, spr_cam_1c, spr_pirate_cove,			spr_cam_pirate_cove);
cams[3] = new cam_create(locations.HallwayLeftA,968, 596, 992, 616, spr_cam_2a, spr_hallway_leftA,			spr_cam_east_hall);
cams[4] = new cam_create(locations.HallwayLeftB, 968, 636, 992, 656, spr_cam_2b, spr_hallway_leftB,			spr_cam_east_hall_corner);
cams[5] = new cam_create(locations.Closet, 884, 572, 908, 592, spr_cam_3, spr_supply_closet,			spr_cam_supply_closet);
cams[6] = new cam_create(locations.HallwayRightA, 1076, 596, 1100, 616,spr_cam_4a, spr_hallway_rightA,		spr_cam_west_hall);
cams[7] = new cam_create(locations.HallwayRightB, 1076, 636, 1100, 656,spr_cam_4b, spr_hallway_rightB,		spr_cam_west_hall_corner);
cams[8] = new cam_create(locations.Backstage, 844, 424, 868, 444, spr_cam_5, spr_backstage,				spr_cam_backstage);
cams[9] = new cam_create(locations.Kitchen, 1172, 556, 1196, 576, spr_cam_6, spr_blank,				spr_cam_kitchen);
cams[10] = new cam_create(locations.Restrooms, 1176, 432, 1200, 452, spr_cam_7, spr_restrooms,			spr_cam_restrooms);

camera_locations = {
	STAGE: cams[0],	
	PARTY_ROOM: cams[1],
	PIRATE_COVE: cams[2],
	HALLWAYLEFTA: cams[3],
	HALLWAYLEFTB: cams[4],
	CLOSET: cams[5],
	HALLWAYRIGHTA: cams[6],
	HALLWAYRIGHTB: cams[7],
	BACKSTAGE: cams[8],
	KITCHEN: cams[9],
	RESTROOMS: cams[10]
}

cams[0].location_name = "STAGE";
cams[1].location_name = "PARTY_ROOM";
cams[2].location_name = "PIRATE_COVE";
cams[3].location_name = "HALLWAYLEFTA";
cams[4].location_name = "HALLWAYLEFTB";
cams[5].location_name = "CLOSET";
cams[6].location_name = "HALLWAYRIGHTA";
cams[7].location_name = "HALLWAYRIGHTB";
cams[8].location_name = "BACKSTAGE";
cams[9].location_name = "KITCHEN";
cams[10].location_name = "RESTROOMS";

cams[9].disabled = true;

// Set selected
if (game_settings.last_location != -1) {
	var _cam = camera_locations[$ game_settings.last_location];
	/*show_message(global.game_settings.last_location);
	show_message(_cam);*/
	if (_cam != undefined) {
		_cam.selected = true;
		currentCamera = _cam;
		backSprite = _cam.scene;
	} else {
		cams[0].selected = true;
		currentCamera = cams[0];
	}
} else {
	cams[0].selected = true;
	currentCamera = cams[0];
}

sceneSwitch();