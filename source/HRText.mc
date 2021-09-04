using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.Activity as Activity;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module HRText {

	var locX;
	var locY;
	
	var iconLocX;
	var iconLocY;
	
	var textHeight;
	var textWidth;
	
	var width;
	
	var activityInfo;
	var value;
	var sample;
	var HR;
	
	var ICON_WIDTH = 16;
	
	function drawHR(dc, left) {
	
		// Get the data
		activityInfo = Activity.getActivityInfo();
		sample = activityInfo.currentHeartRate;
		if (sample != null) {
			value = sample;
		} else if (ActivityMonitor has :getHeartRateHistory) {
			sample = ActivityMonitor.getHeartRateHistory(1, /* newestFirst */ true)
				.next();
			if ((sample != null) && (sample.heartRate != ActivityMonitor.INVALID_HR_SAMPLE)) {
				value = sample.heartRate;
			}
		}
		
		HR = (value != null) ? value : "--";
		
		// Debug
		// HR = 65;
		
		HR = Lang.format("$1$", [HR]);
		
		
		// Calculate position
		width = dc.getWidth();
		textWidth = dc.getTextWidthInPixels(HR, dc.FONT_SYSTEM_XTINY);
		
		iconLocX = width / 6 - ICON_WIDTH / 2;
		iconLocY = width / 2 - ICON_WIDTH;
		
		locX = width / 6 - textWidth / 2;
		locY = width / 2;
		
		if (!left) {
			iconLocX += width / 6 * 4;
			locX += width / 6 * 4;
		}
		
		// Draw icon and text
		dc.drawBitmap(iconLocX, iconLocY, WatchUi.loadResource(Rez.Drawables.HeartIcon));
		dc.drawText(locX, locY, dc.FONT_SYSTEM_XTINY, HR, dc.TEXT_JUSTIFY_LEFT);
		
	}
}