using Toybox.WatchUi;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Graphics as Gfx;

class SeasonWidgetView extends WatchUi.View {
    // Text variables for displaying season/title
	var seasonTxtSummer, seasonTxtAutumnal, seasonTxtWinter, seasonTxtVernal;
	var seasonSouthTxtSummer, seasonSouthTxtAutumnal, seasonSouthTxtWinter, seasonSouthTxtVernal;
	var titleText = "Seasons";
	var fullDateText = "";
	var julianDateText = "";
	var seasonText = "";
	var seasonImgSummer, seasonImgAutumnal, seasonImgWinter, seasonImgVernal;
	var optionImgMeteorol, optionImgAstrol;
	var hemImgNorth, hemImgSouth;
	var image = "";
	var optionImage = "";
	var hemImage = "";
	
    hidden enum
    {
    	AUTUMNAL,
    	WINTER,
    	VERNAL,
    	SUMMER
    }
    
    hidden var nothern_hemisphere;
    hidden var astrological_option;
    hidden var transistion_semaphore;

    function initialize() {
        View.initialize();
        // Init text
        seasonTxtSummer = WatchUi.loadResource( Rez.Strings.summer_text_id );
        seasonTxtAutumnal = WatchUi.loadResource( Rez.Strings.autumnal_text_id );
        seasonTxtWinter = WatchUi.loadResource( Rez.Strings.winter_text_id );
        seasonTxtVernal = WatchUi.loadResource( Rez.Strings.vernal_text_id );
        seasonSouthTxtSummer = WatchUi.loadResource( Rez.Strings.south_summer_text_id );
        seasonSouthTxtAutumnal = WatchUi.loadResource( Rez.Strings.south_autumnal_text_id );
        seasonSouthTxtWinter = WatchUi.loadResource( Rez.Strings.south_winter_text_id );
        seasonSouthTxtVernal = WatchUi.loadResource( Rez.Strings.south_vernal_text_id );
        // Init images
        seasonImgSummer = WatchUi.loadResource( Rez.Drawables.summer_img_id );
        seasonImgAutumnal = WatchUi.loadResource( Rez.Drawables.autumnal_img_id );
        seasonImgWinter = WatchUi.loadResource( Rez.Drawables.winter_img_id );
        seasonImgVernal = WatchUi.loadResource( Rez.Drawables.vernal_img_id );
        optionImgMeteorol = WatchUi.loadResource( Rez.Drawables.meteorol_img_id );
        optionImgAstrol = WatchUi.loadResource( Rez.Drawables.astrol_img_id );
        hemImgNorth = WatchUi.loadResource( Rez.Drawables.north_hem_img_id );
        hemImgSouth = WatchUi.loadResource( Rez.Drawables.south_hem_img_id );
        // Init global variables
        nothern_hemisphere = true;
        astrological_option = true;
        transistion_semaphore = false;
        // Default hemisphere to North
        hemImage = hemImgNorth;
    }

    // Load your resources here
    function onLayout(dc) {
		image = "Loading...";
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }
    
    // Called to for onUpdate function
    function updateCallback(){
    	WatchUi.requestUpdate();
    }
    
    // Called from Delegate to set transition
    function getTransition(){
    	return transistion_semaphore;
    }
    
    // Called from Delegate to get transition
    function setTransition(value){
    	transistion_semaphore = value;
    	updateCallback();
    }
    
    // Called from Delegate to get astrological/meteorlogical option
    function getOption(){
    	return astrological_option;
    }
    
    // Called from Delegate to set astrological/meteorlogical option
    function setOption(value){
    	astrological_option = value;
    	updateCallback();
    }
    
    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout   
        dc.setColor(Gfx.COLOR_WHITE,Gfx.COLOR_BLACK);    
   
        dc.clear();
        var width, height;
        
		width = dc.getWidth();
        height = dc.getHeight();
        
        // Determine if is transition animation should be drawn
        if ( true == getTransition() ){
        
	        dc.setColor(Gfx.COLOR_WHITE,Gfx.COLOR_BLACK);    
	        dc.clear();
	        if (nothern_hemisphere == true){
	            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
	            dc.fillCircle(width/2, height/2+10, 100);
	            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
	            dc.fillRectangle(0, height/2-140, 250, 150);
	            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
	            dc.fillRectangle(30, height/2-20, 50, 10);
	            dc.fillRectangle(105, height/2-20, 50, 10);
	            dc.fillRectangle(180, height/2-20, 50, 10);
	            dc.drawText(width/2, height/2-75, Gfx.FONT_MEDIUM, "Southern", Gfx.TEXT_JUSTIFY_CENTER);
	            // Update hemisphere indicator on seasons graphic
	            hemImage = hemImgSouth;
	            nothern_hemisphere = false;
	    	}
	    	else {
	            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
	            dc.fillCircle(width/2, height/2-10, 100);
	            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
	            dc.fillRectangle(0, height/2, 250, 150);
	           	dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
	            dc.fillRectangle(30, height/2+20, 50, 10);
	            dc.fillRectangle(105, height/2+20, 50, 10);
	            dc.fillRectangle(180, height/2+20, 50, 10);	
	            dc.drawText(width/2, height/2+50, Gfx.FONT_MEDIUM, "Northern", Gfx.TEXT_JUSTIFY_CENTER);
	            // Update hemisphere indicator on seasons graphic
	            hemImage = hemImgNorth;
	            nothern_hemisphere = true;
	    	}	
        }
        else {
	        // Determine season based on astrological or meteorological
	        var time_current = Time.now();

	        // Set Full Date
	        var today = Gregorian.info(time_current, Time.FORMAT_MEDIUM);
	        fullDateText = Lang.format(
			    "$1$ $2$ $3$ $4$",
			    [
			        today.day_of_week,
			        today.day,
			        today.month,
			        today.year
			    ]
			);
	        
	        var season_code = AUTUMNAL;
	        var today_short = Gregorian.info(time_current, Time.FORMAT_SHORT);
	        var leap_year = Leap_Year_Check(today_short.year);
	        var julian_days = Get_Julian_Days(today_short,leap_year);
	        var julian_date = Get_Julian_Date(today_short,leap_year);
	        
	        // Set Julian Date 
	        julianDateText = "Julian Days/Date: " + julian_days.toString()+"/"+julian_date.toString();
	        
	        if (astrological_option == true) {
	        	season_code = Astro_Update(julian_days, leap_year);
	        	titleText = "Astrol.";
	        	optionImage = optionImgAstrol;
	        }
	        else{
	            season_code = Meteoro_Update(julian_days, leap_year);
	            titleText = "Meteorol.";
	            optionImage = optionImgMeteorol;
	        }
	        
	        setHemDisplayHelper(season_code);
			
		    // Do draw operations
		    dc.drawText(width/2, 2, Gfx.FONT_MEDIUM, titleText, Gfx.TEXT_JUSTIFY_CENTER);
		    dc.drawText(width/2, height - 230, Gfx.FONT_TINY, fullDateText, Gfx.TEXT_JUSTIFY_CENTER);
		    dc.drawBitmap( width/2 - 50, height/2 - 62, image );
		    dc.drawBitmap( width/2 - 89, height/2 - 62, optionImage );
		    dc.drawBitmap( width/2 - 13, height/2 - 76, hemImage );
		    dc.drawText(width/2, height - 79, Gfx.FONT_XTINY, julianDateText, Gfx.TEXT_JUSTIFY_CENTER);
		    dc.drawText(width/2, height - 64, Gfx.FONT_XTINY, seasonText, Gfx.TEXT_JUSTIFY_CENTER);
    	}
    }

    // Called for parsing date if Astrological seasons chosen (defaults to northern hemisphere)
    function Astro_Update(julian_days, leap_year) {
        var leap_offset = 0;
        if (leap_year){
        	leap_offset = 1;
        }

	    if ((julian_days >= (79 + leap_offset)) && (julian_days < (171 + leap_offset))) {
	        return VERNAL;
	    }
	    else if ((julian_days >= (171 + leap_offset)) && (julian_days < (265 + leap_offset))) {
	        return SUMMER; 
	    }
	    else if ((julian_days >= (265 + leap_offset)) && (julian_days < (355 + leap_offset))) {
	        return AUTUMNAL; 
	    }
	    else {
			return WINTER;
	    }
    }
    
    // Called for parsing date if Meterological seasons chosen (defaults to northern hemisphere)
    function Meteoro_Update(julian_days, leap_year) {
        var leap_offset = 0;
        if (leap_year){
        	leap_offset = 1;
        }

	    if ((julian_days >= (60 + leap_offset)) && (julian_days < (152 + leap_offset))) {
	        return VERNAL;
	    }
	    else if ((julian_days >= (152 + leap_offset)) && (julian_days < (244 + leap_offset))) {
	        return SUMMER; 
	    }
	    else if ((julian_days >= (244 + leap_offset)) && (julian_days < (335 + leap_offset))) {
	        return AUTUMNAL; 
	    }
	    else {
			return WINTER;
	    }
    }

    // Updates the display with corresponding season image/text, accounts for hemisphere
    function setHemDisplayHelper(season) {
		if(season == VERNAL) {
			if (nothern_hemisphere == true) {
		        image = seasonImgVernal;
		        seasonText = seasonTxtVernal;
		    }
		    else{
		        image = seasonImgAutumnal;
		        seasonText = seasonSouthTxtAutumnal;
		    }  
	        // June append text
	        seasonText += (astrological_option ? "20th" : "1st");  		
		}
		else if(season == SUMMER) {
			if (nothern_hemisphere == true) {
            	image = seasonImgSummer;
	        	seasonText = seasonTxtSummer;
	   		}
		    else{
		        image = seasonImgWinter;
		        seasonText = seasonSouthTxtWinter;	        	
		    } 
        	// Sept. append text
        	seasonText += (astrological_option ? "22nd" : "1st"); 
		}
		else if(season == AUTUMNAL) {
			if (nothern_hemisphere == true) {
  	        	image = seasonImgAutumnal;
	        	seasonText = seasonTxtAutumnal;
	        }
	        else{
		        image = seasonImgVernal;
		        seasonText = seasonSouthTxtVernal;
		    }  
            // Dec. append text
	        seasonText += (astrological_option ? "21st" : "1st");
		}
		// WINTER
		else {
			if (nothern_hemisphere == true) {
	    		image = seasonImgWinter;
		        seasonText = seasonTxtWinter;
		    }
	     	else{
		        image = seasonImgSummer;
		        seasonText = seasonSouthTxtSummer;	        	
		    } 
	        // March append text
        	seasonText += (astrological_option ? "20th" : "1st");
		}
    }
    
    
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    // Function to determine leap year and return boolean
    function Leap_Year_Check(year){
    	var leap_year = false;
		if (year % 4 == 0) {
	      if ((year % 100 == 0) && (year % 400 == 0)){
	      	leap_year = true;
	      }
	      else {
	        leap_year = true;
	      }
	    }
	    
    	return leap_year;
    
    }
    
    // Function to determine the julian days
    function Get_Julian_Days(today, leap_year){
    	var julian_days = 0;
    	var leap_offset = 0;
        // Days in months
        var month_values = [31,28,31,30,31,30,31,31,30,31,30,31];
        if (leap_year){
            month_values[1] = 29;
        	leap_offset = 1;
        }

         var i;
         for (i=0; i < (today.month-1); i++)
         {
          julian_days += month_values[i];
         }
         julian_days += today.day;
 
    	return julian_days;
    }
    
    // Function to determine the julian date which is days including year
    function Get_Julian_Date(today, leap_year){
        var julian_date = 0;
        // Get century code only support (19th century upwards)
        var year_hi = Math.round(today.year/100);
        var century_code = year_hi - 19;
        
    	var julian_days = Get_Julian_Days(today, leap_year);
		
		julian_date += century_code*100000;
	    julian_date += (today.year - (year_hi*100))*1000;
	    julian_date += julian_days;
	    
    	return julian_date; 
    }

}
