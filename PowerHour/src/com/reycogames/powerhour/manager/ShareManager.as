package com.reycogames.powerhour.manager
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class ShareManager
	{		
		public static var POWER_HOUR_LINK:String 	= "http://powerhour-drinking-game.com";
		public static var initialized:Boolean 		= false;
		
		public static function initialize():void
		{
			if(initialized == false)
			{
				trace("[ShareManager]", "GoViral initialized!");				
				initialized = true;
			}
			else 
			{
				trace("[ShareManager]", "GoViral only works on mobile!");
			}
		}
		
		public static function shareOnFacebook( link:String = null ):void
		{
			navigateToURL(new URLRequest( "http://www.facebook.com/sharer.php?u=" + ( link == null ? POWER_HOUR_LINK : link ) ));
		}
		
		public static function shareOnTwitter( link:String = null ):void
		{
			navigateToURL(new URLRequest( "https://twitter.com/home?status=" + ( link == null ? POWER_HOUR_LINK : link ) ));
		}
		
		public static function shareOnGooglePlus( link:String = null ):void
		{
			navigateToURL(new URLRequest( "https://plus.google.com/share?url=" + ( link == null ? POWER_HOUR_LINK : link ) ));
		}
	}
}