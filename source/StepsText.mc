using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module StepsText {

	var locX;
	var locY;
	
	var iconLocX;
	var iconLocY;
	
	var textHeight;
	var textWidth;
	
	var width;
	
	var info;
	var steps;
	
	var ICON_WIDTH = 16;
	
	function drawSteps(dc, left) {
	
		// Get the data
		info = ActivityMonitor.getInfo();
		steps = (info.steps != null) ? info.steps : "--";
		
		// Debug
		// steps = 17789;
		
		if (steps > 1000) {
			steps = steps / 1000.0;
			steps = Lang.format("$1$ $2$", [steps.format("%.1f"), "K"]);
		}
		steps = Lang.format("$1$", [steps]);
		
		
		// Calculate position
		width = dc.getWidth();
		textWidth = dc.getTextWidthInPixels(steps, dc.FONT_SYSTEM_XTINY);
		
		iconLocX = width / 6 - ICON_WIDTH / 2;
		iconLocY = width / 2 - ICON_WIDTH;
		
		locX = width / 6 - textWidth / 2;
		locY = width / 2;
		
		if (!left) {
			iconLocX += width / 6 * 4;
			locX += width / 6 * 4;
		}
		
		// Draw icon and text
		dc.drawBitmap(iconLocX, iconLocY, WatchUi.loadResource(Rez.Drawables.StepsIcon));
		dc.drawText(locX, locY, dc.FONT_SYSTEM_XTINY, steps, dc.TEXT_JUSTIFY_LEFT);
		
	}
}