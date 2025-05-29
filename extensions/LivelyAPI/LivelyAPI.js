var gmlLivelyProperties = {};
var gmlLivelyCurrentKey = "unknown";

function LivelyGetValue(_str) {
	return gmlLivelyProperties[_str];
}

function LivelyGetKey() {
	return gmlLivelyCurrentKey;
}

function LivelyGetNames() {
	let array = [];
	Object.keys(gmlLivelyProperties).forEach(function(key) {
		array.push(key);
	});
	return array;
}

function livelyPropertyListener(name, val) {
	gmlLivelyProperties[name] = val;
}

function LivelySetup() {
	livelyPropertyListener = function(name, val) {
		gmlLivelyProperties[name] = val;
		gmlLivelyCurrentKey = name;
		gml_Script_gmcallback_livelyUpdateProperties();
	}
}