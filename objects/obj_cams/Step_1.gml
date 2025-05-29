//wallpaperEngineProcces();

if (lw_subs_data != undefined) {
	if (lw_subs_data[$ "battery"] != undefined) && (array_length(lw_subs_data.battery) > 0) {
		batteryPercent = round(lw_subs_data.battery[0][$ "remaining_charge_pct"] ?? 100);
	}
}