/*global.weMouseDown = false;
global.weMousePressed = false;
global.weMouseReleased = false;

function gmcallback_wallpaperEngineUpdateClick(_state) {
	global.weMouseDown = _state;
	if (global.weMouseDown == true) {
		global.weMousePressed = true;	
	} else {
		global.weMouseReleased = true;	
	}
}

function wallpaperEngineProcces() {
	global.weMouseReleased = false;
	global.weMousePressed = false;
}

function wallpaperEngineUpdateClick(_state) {
	gmcallback_wallpaperEngineUpdateClick(_state);
}

function wallpaperEngineGetMouse() {
	return global.weMouseDown;
}

function wallpaperEngineGetMousePressed() {
	return global.weMousePressed;
}

function wallpaperEngineGetMouseReleased() {
	return global.weMouseReleased;
}