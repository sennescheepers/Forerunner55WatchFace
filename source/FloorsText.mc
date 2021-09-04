using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module FloorsText {

	var locX;
	var locY;
	
	var iconLocX;
	var iconLocY;
	
	var textHeight;
	var textWidth;
	
	var width;
	
	var info;
	var floors;
	
	var ICON_WIDTH = 16;
	
	function drawFloors(dc, left) {
	
		// Get the data
		info = ActivityMonitor.getInfo();
		if (info has :floorsClimbed) {
			floors = (info.floorsClimbed != null) ? info.floorsClimbed : "--";
		} else {
			floors = "--";
		}
		
		// Debug
		// floors = 12;
		
		floors = Lang.format("$1$", [floors]);
		
		
		// Calculate position
		width = dc.getWidth();
		textWidth = dc.getTextWidthInPixels(floors, dc.FONT_SYSTEM_XTINY);
		
		iconLocX = width / 6 - ICON_WIDTH / 2;
		iconLocY = width / 2 - ICON_WIDTH;
		
		locX = width / 6 - textWidth / 2;
		locY = width / 2;
		
		if (!left) {
			iconLocX += width / 6 * 4;
			locX += width / 6 * 4;
		}
		
		// Draw icon and text
		dc.drawBitmap(iconLocX, iconLocY, WatchUi.loadResource(Rez.Drawables.StairsIcon));
		dc.drawText(locX, locY, dc.FONT_SYSTEM_XTINY, floors, dc.TEXT_JUSTIFY_LEFT);
		
	}
}