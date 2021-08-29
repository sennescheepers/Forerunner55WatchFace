using Toybox.System;
using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.Lang as Lang;
using Toybox.Application;

module SecondsRing {

	var displaySeconds;
	var lowPower = false;
	
	var RING_WIDTH = 3;
	
	function drawSeconds(dc) {
	
		var centerX = dc.getWidth() / 2;
		var centerY = centerX;
		var radius = centerX - 1;
		
		var moment = Gregorian.info(Time.now(), Time.FORMAT_LONG);
		var seconds = moment.sec;
		var angle = (90 - 359 * (seconds / 60.0)).toNumber();
		
		if (displaySeconds && !lowPower && (angle != 450 || angle != 90)) {
			dc.setColor(dc.COLOR_WHITE, dc.COLOR_BLACK);
			dc.setPenWidth(RING_WIDTH);
			if (dc has :setAntiAlias) {
				dc.setAntiAlias(true);
			}
			dc.drawArc(centerX, centerY, radius - 1, dc.ARC_CLOCKWISE, 90, angle);
		}		

	}
 	
	function setSettings() {
		
		displaySeconds = Application.getApp().getProperty("DisplaySeconds");
	
	}

}