using Toybox.System;
using Toybox.WatchUi;
using Toybox.Timer;

class SeasonWidgetDelegate extends WatchUi.BehaviorDelegate {
    
    var view;
    hidden var swipe_enabled;
    
    function initialize(v) {
        BehaviorDelegate.initialize();
        view = v;
        swipe_enabled = true;
    }
    
    // Tap for changing the astrological/meteorological option
    function onTap(clickEvent) {

        var click_evt = clickEvent.getType();
        if ((click_evt == CLICK_TYPE_TAP)) {
	        // Toggle option if tap
	        if (true == view.getOption()) {
	        	view.setOption(false);
	        }
	        else {
	         	view.setOption(true);
	        }
        }

        return true;
    }
    
    // Swipe for changing the hemisphere (Northern/Southern)
    function onSwipe(swipeEvent) {

        var swipe_evt = swipeEvent.getDirection();     
        if (swipe_enabled == true) {
	        if ((swipe_evt == SWIPE_LEFT)) {
		        // Toggle swiping enabled while transitioning
		        swipe_enabled = false;
		        // Toggle option if swipe SWIPE_LEFT
		        view.setTransition(true);
		        var myTimer = new Timer.Timer();
	            myTimer.start(method(:updateTransitionOff), 500, false);
	        }
        }

        return true;
    }
    
    // Callback to update transition after half a second
    function updateTransitionOff(){
        view.setTransition(false);
        swipe_enabled = true;
    	return true;
    }
    
}