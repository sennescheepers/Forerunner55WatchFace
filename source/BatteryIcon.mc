using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Lang as Lang;
using Toybox.Application;

module BatteryIcon {

	var locX;
	var locY;
	var width = 24;
	var height;
	
	var dateHeight;
	
	var totalWidth;
	
	var batteryPercentage;
	
	function drawBattery(dc) {
	
		dateHeight = dc.getFontHeight(dc.FONT_SYSTEM_TINY);
		height = dateHeight - 14;
		
		totalWidth = width + DateText.textWidth + 10;
		
		locX = (dc.getWidth() - DateText.textWidthHour) / 2 + 8;
		locY = dc.getHeight() / 2 + TimeText.textHeight + 2 + 7;
		
		// Draw outline
		dc.setColor(dc.COLOR_WHITE, dc.COLOR_BLACK);
		dc.setPenWidth(1);
		dc.drawRectangle(locX, locY, width, height);
		
		// Draw battery knob thing
		dc.drawLine(locX + width + 1, locY + 2, locX + width + 1, locY + height - 2);
		
		// Draw inside
		batteryPercentage = System.getSystemStats().battery / 100.0;
		dc.fillRectangle(locX + 2, locY + 2, (width - 4) * batteryPercentage, height - 4);
	
	}

}