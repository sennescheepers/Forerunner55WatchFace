using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
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
	
	var moment;
	var hourString;
	var minutesString;
	
	var hourLocX;
	var hourLocY;
	var minutesLocX;
	var minutesLocY;
	
	function drawTime(dc) {
	// Get the time information
		moment = Gregorian.info(Time.now(), Time.FORMAT_LONG);
		hourString;
		if (System.getDeviceSettings().is24Hour && !use12Hour) {
			hourString = moment.hour.format("%02d");
		} else {
			hourString = (moment.hour > 12) ? moment.hour % 12 : moment.hour;
			hourString = hourString.format("%02d");
		}
		minutesString = moment.min.format("%02d");
		
		// Getting text widths and heights
		textWidthHour = dc.getTextWidthInPixels(hourString, Fonts.bigFilledFont);
		textWidthMinutes = dc.getTextWidthInPixels(minutesString, Fonts.bigFilledFont);
		
		textHeight = dc.getFontHeight(Fonts.bigFilledFont);
		
		// Calculating text postions
		hourLocX = (dc.getWidth() - textWidthHour) / 2;
		hourLocY = dc.getHeight() / 2 - textHeight - 12;
		minutesLocX = (dc.getWidth() - textWidthMinutes) / 2;
		minutesLocY = dc.getHeight() / 2 - 6;
		
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