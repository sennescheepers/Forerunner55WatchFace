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

module DataFields {

	var leftDataField;
	var rightDataField;
	
	var locX;
	var locY;
	
	var iconLocX;
	var iconLocY;
	
	var textHeight;
	var textWidth;
	
	var width;
	
	var info;
	
	var useImperial = System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE;

	var ICON_WIDTH = 16;
	
	function drawDataFields(dc) {
	
		// Display data fields
        // 0: Empty
        // 1: HR
      	// 2: Steps
      	// 3: Floors
      	// 4: Calories
      	// 5: Distance
      	if (leftDataField == 1) {
      		drawHR(dc, true);
      	} else if (leftDataField == 2) {
      		drawSteps(dc, true);
      	} else if (leftDataField == 3) {
      		drawFloors(dc, true);
      	} else if (leftDataField == 4) {
      		drawCalories(dc, true);
      	} else if (leftDataField == 5) {
      		drawDistance(dc, true);
      	}
      	
      	if (rightDataField == 1) {
      		drawHR(dc, false);
      	} else if (rightDataField == 2) {
      		drawSteps(dc, false);
      	} else if (rightDataField == 3) {
      		drawFloors(dc, false);
      	} else if (rightDataField == 4) {
      		drawCalories(dc, false);
      	} else if (rightDataField == 5) {
      		drawDistance(dc, false);
      	}
	
	}
	
	function drawHR(dc, left) {
	
		var activityInfo;
		var value = "--";
		var sample;
		var HR;
	
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
		} else {
			value = "--";
		}
		
		// Debug
		// HR = 65;
		
		HR = Lang.format("$1$", [value]);
		
		
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
	
	function drawSteps(dc, left) {
	
		var steps;
	
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
	
	function drawFloors(dc, left) {
	
		var floors;
	
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
	
	function drawCalories(dc, left) {
	
		var calories;
	
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
	
	function drawDistance(dc, left) {
	
		// Get the data
		info = ActivityMonitor.getInfo();
		var distance = (info.distance != null) ? info.distance / 100 : 0;
		var unit = "m";
		if (distance >= 1000 && !useImperial) {
			distance = distance / 1000.0;
			distance = (distance * 10).toNumber().toFloat() / 10;
			distance = distance.format("%.1f");
			unit = "km";
		} else if (useImperial) {
			distance = distance / 1609.344;
			distance = (distance * 10).toNumber().toFloat() / 10;
			distance = distance.format("%.1f");
		}
		var distanceString = Lang.format("$1$$2$", [distance, unit]);
		
		// Calculate position
		width = dc.getWidth();
		textWidth = dc.getTextWidthInPixels(distanceString, dc.FONT_SYSTEM_XTINY);
		
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
		dc.drawText(locX, locY, dc.FONT_SYSTEM_XTINY, distanceString, dc.TEXT_JUSTIFY_LEFT);
	
	}
	
	function setSettings() {
	
		leftDataField = Application.getApp().getProperty("LeftDataField");
    	rightDataField = Application.getApp().getProperty("RightDataField");
		
	}

}