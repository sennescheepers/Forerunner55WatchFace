using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Application;

module TimeText {
	
	var use12Hour;
	
	var textWidthHour;
	var textWidthMinutes;
	var textHeight;
	
	var hourColor;
	var minutesColor;
	
	var hourFilled;
	var minutesFilled;
	
	function drawTime(dc) {
	// Get the time information
		var moment = Gregorian.info(Time.now(), Time.FORMAT_LONG);
		var hourString;
		if (System.getDeviceSettings().is24Hour && !use12Hour) {
			hourString = moment.hour.format("%02d");
		} else {
			hourString = (moment.hour > 12) ? moment.hour % 12 : moment.hour;
			hourString = hourString.format("%02d");
		}
		var minutesString = moment.min.format("%02d");
		
		// Getting text widths and heights
		textWidthHour = dc.getTextWidthInPixels(hourString, Fonts.bigFilledFont);
		textWidthMinutes = dc.getTextWidthInPixels(minutesString, Fonts.bigFilledFont);
		
		textHeight = dc.getFontHeight(Fonts.bigFilledFont);
		
		// Calculating text postions
		var hourLocX = (dc.getWidth() - textWidthHour) / 2;
		var hourLocY = dc.getHeight() / 2 - textHeight - 2;
		var minutesLocX = (dc.getWidth() - textWidthMinutes) / 2;
		var minutesLocY = dc.getHeight() / 2 + 2;
		
		// Deciding fonts and drawing text
		if (hourFilled) {
			dc.setColor(hourColor, Graphics.COLOR_BLACK);
			dc.drawText(hourLocX, hourLocY, Fonts.bigFilledFont, hourString, Graphics.TEXT_JUSTIFY_LEFT);
		} else {
			dc.setColor(hourColor, Graphics.COLOR_BLACK);
			dc.drawText(hourLocX, hourLocY, Fonts.bigOutlineFont, hourString, Graphics.TEXT_JUSTIFY_LEFT);
		}
		if (minutesFilled) {
			dc.setColor(minutesColor, Graphics.COLOR_BLACK);
			dc.drawText(minutesLocX, minutesLocY, Fonts.bigFilledFont, minutesString, Graphics.TEXT_JUSTIFY_LEFT);
		} else {
			dc.setColor(minutesColor, Graphics.COLOR_BLACK);
			dc.drawText(minutesLocX, minutesLocY, Fonts.bigOutlineFont, minutesString, Graphics.TEXT_JUSTIFY_LEFT);
		}
		
	}
	
	
	function setSettings() {
	
		hourColor = Application.getApp().getProperty("HourColor");
		minutesColor = Application.getApp().getProperty("MinutesColor");
		hourFilled = Application.getApp().getProperty("HourFilled");
		minutesFilled = Application.getApp().getProperty("MinutesFilled");
		use12Hour = Application.getApp().getProperty("Use12Hour");
	
	}
	
}