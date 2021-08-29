import Toybox.System;
import Toybox.WatchUi;

module StatusIcons {

	var settings;

	var ICON_WIDTH = 12;
	var SPACING = 4;
	
	var totalWidth;
	
	var phoneConnected;
	var hasNotification;
	var doNotDisturb;
	var alarmEnabled;

	var iconsToDraw;
	var numberOfIcons;
	
	var locX;
	var locY = 20;

	function drawIcons(dc) {
	
		iconsToDraw = new [4];
		numberOfIcons = 0;
		totalWidth = 0;
	
		// Check which icons to display
		settings = System.getDeviceSettings();
	
		phoneConnected = settings.phoneConnected;
		alarmEnabled = settings.alarmCount > 0;
		doNotDisturb = (settings has :doNotDisturb) ? settings.doNotDisturb : false;
		hasNotification = settings.notificationCount > 0;
		
		// Get total width of displayed icons
		if (phoneConnected) {
			totalWidth += ICON_WIDTH;
			iconsToDraw[numberOfIcons] = "phone";
			numberOfIcons++;
		}
		if (hasNotification) {
			totalWidth += ICON_WIDTH;
			iconsToDraw[numberOfIcons] = "notification";
			numberOfIcons++;
		}
		if (doNotDisturb) {
			totalWidth += ICON_WIDTH;
			iconsToDraw[numberOfIcons] = "dnd";
			numberOfIcons++;
		}
		if (alarmEnabled) {
			totalWidth += ICON_WIDTH;
			iconsToDraw[numberOfIcons] = "alarm";
			numberOfIcons++;
		}
		totalWidth += ((totalWidth / ICON_WIDTH) - 1) * SPACING;
		
		// Calculate left most position
		locX = (dc.getWidth() - totalWidth) / 2;
		
		// Draw icons
		for (var i = 0; i < numberOfIcons; i++) {
		
			var type = iconsToDraw[i];
			
			if (type.equals("phone")) {
				dc.drawBitmap(locX, locY, WatchUi.loadResource(Rez.Drawables.PhoneIcon));
			} else if (type.equals("notification")) {
				dc.drawBitmap(locX, locY, WatchUi.loadResource(Rez.Drawables.NotificationIcon));
			} else if (type.equals("dnd")) {
				dc.drawBitmap(locX, locY, WatchUi.loadResource(Rez.Drawables.DoNotDisturbIcon));
			} else if (type.equals("alarm")) {
				dc.drawBitmap(locX, locY, WatchUi.loadResource(Rez.Drawables.AlarmIcon));
			}
		
			locX += ICON_WIDTH + SPACING;
		}
		
		//dc.drawBitmap(120, 120, WatchUi.loadResource(Rez.Drawables.PhoneIcon));
	
	}

}