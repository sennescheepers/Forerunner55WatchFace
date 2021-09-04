import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class Forerunner55WatchFaceView extends WatchUi.WatchFace {
        
    var leftDataField;
    var rightDataField;

    function initialize() {
        WatchFace.initialize();
        
        setSettings();
        
        // Setting up the settings variables here for effeciency
        TimeText.setSettings();
        SecondsRing.setSettings();
        
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw time
        TimeText.drawTime(dc);
        
        // Draw seconds ring
        SecondsRing.drawSeconds(dc);
        
        // Draw date
        DateText.drawDate(dc);
        
        // Draw battery icon
        BatteryIcon.drawBattery(dc);
        
        // Draw status icons
        StatusIcons.drawIcons(dc);
        
        // Display data fields
        // 0: Empty
        // 1: HR
      	// 2: Steps
      	// 3: Floors
      	if (leftDataField == 1) {
      		HRText.drawHR(dc, true);
      	} else if (leftDataField == 2) {
      		StepsText.drawSteps(dc, true);
      	} else if (leftDataField == 3) {
      		FloorsText.drawFloors(dc, true);
      	} else if (leftDataField == 4) {
      		CaloriesText.drawCalories(dc, true);
      	}
      	
      	if (rightDataField == 1) {
      		HRText.drawHR(dc, false);
      	} else if (rightDataField == 2) {
      		StepsText.drawSteps(dc, false);
      	} else if (rightDataField == 3) {
      		FloorsText.drawFloors(dc, false);
      	} else if (rightDataField == 4) {
      		CaloriesText.drawCalories(dc, false);
      	}
      	
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    	SecondsRing.lowPower = false;
    	WatchUi.requestUpdate();
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    	SecondsRing.lowPower = true;
    }
    
    function setSettings() {
    	leftDataField = Application.getApp().getProperty("LeftDataField");
    	rightDataField = Application.getApp().getProperty("RightDataField");
    }

}
