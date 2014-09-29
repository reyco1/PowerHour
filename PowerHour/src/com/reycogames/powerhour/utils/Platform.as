package com.reycogames.powerhour.utils
{
	import flash.system.Capabilities;
	
	public class Platform
	{
		public static const LANDSCAPE:String = "landscape";
		public static const PORTRAIT:String  = "porttrait";
		
		public static var STAGE_WIDTH:int 	= 960;
		public static var STAGE_HEIGHT:int 	= 540;
		
		private static var _orientation:String = LANDSCAPE;
		
		public static function get orientation():String
		{
			return _orientation;
		}

		public static function set orientation(value:String):void
		{
			_orientation = value;
			if(_orientation == LANDSCAPE)
			{
				STAGE_WIDTH  = 960;
				STAGE_HEIGHT = 540;
			}
			else
			{
				STAGE_WIDTH  = 540;
				STAGE_HEIGHT = 960;
			}
		}

		public static function isIOS():Boolean
		{
			return (Capabilities.version.substr(0, 3) == "IOS");
		}
		
		public static function isAndroid():Boolean
		{
			return (Capabilities.version.substr(0, 3) == "AND");
		}
		
		public static function isWindows():Boolean
		{
			return (Capabilities.version.substr(0, 3) == "WIN");
		}
		
		public static function isMac():Boolean
		{
			return (Capabilities.version.substr(0, 3) == "MAC");
		}
		
		public static function isMobile():Boolean
		{
			return isIOS() || isAndroid();
		}
		
		public static function isDesktop():Boolean
		{
			return !isMobile() &&
				Capabilities.playerType == "Desktop" 	||
				Capabilities.playerType == "StandAlone" ||
				Capabilities.playerType == "External";
		}
		
		public static function isWeb():Boolean
		{
			return Capabilities.playerType == "PlugIn";
		}
		
		public static function supportsAdvancedFeatures():Boolean
		{
			return !isWeb() && !isMobile();
		}
		
		public static function get debugEnabled():Boolean
		{
			return Capabilities.isDebugger;
		}
		
		public static function get PLATFORM():String
		{
			if (isIOS()) 
				return "iOS";
			if (isAndroid()) 
				return "Android";
			if (isWindows()) 
				return "Windows";
			if (isMac()) 
				return "Mac";
			
			return "IDK";
		}
	}
}