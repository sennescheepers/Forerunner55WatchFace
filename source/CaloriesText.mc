using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module CaloriesText {

	var locX;
	var locY;
	
	var iconLocX;
	var iconLocY;
	
	var textHeight;
	var textWidth;
	
	var width;
	
	var info;
	var calories;
	
	var ICON_WIDTH = 16;
	
	function drawCalories(dc, left) {
	
		// Get the data
		info = ActivityMonitor.getInfo();
		calories = (info.calories != null && info has :calories) ? info.calories : "--";
		
		// Debug
		// calories = 17789;
		
		if (calories > 1000) {
			calories = calories / 1000.0;
			calories = Lang.format("$1$ $2$", [calories.format("%.1f"), "K"]);
		}
		calories = Lang.format("$1$", [calories]);
		
		
		// Calculate position
		width = dc.getWidth();
		textWidth = dc.getTextWidthInPixels(calories, dc.FONT_SYSTEM_XTINY);
		
		iconLocX = width / 6 - ICON_WIDTH / 2;
		iconLocY = width / 2 - ICON_WIDTH;
		
		locX = width / 6 - textWidth / 2;
		locY = width / 2;
		
		if (!left) {
			iconLocX += width / 6 * 4;
			locX += width / 6 * 4;
		}
		
		// Draw icon and text
		dc.drawBitmap(iconLocX, iconLocY, WatchUi.loadResource(Rez.Drawables.FireIcon));
		dc.drawText(locX, locY, dc.FONT_SYSTEM_XTINY, calories, dc.TEXT_JUSTIFY_LEFT);
		
	}
}