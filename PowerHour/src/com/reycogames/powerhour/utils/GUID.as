package com.reycogames.powerhour.utils
{
	import flash.net.SharedObject;

	public class GUID
	{
		public static var ID:String;
		
		public static function initialize():void
		{
			ID = load();
			
			if(ID == 'undefined' || ID == null)
			{
				save();
			}
			
			trace('[GUID] device id is', ID);
		}
		
		public static function generate():String
		{
			return String(new Date().time/1000000000).split(".")[1]+"-"+Math.round(Math.random()*999);
		}
		
		private static function save():void 
		{ 
			var so:SharedObject = SharedObject.getLocal("powerhour"); 
			ID = so.data['id'] = generate(); 
			so.flush(); 
		} 
		
		private static function load():String 
		{ 
			var so:SharedObject = SharedObject.getLocal("powerhour"); 
			return so.data['id']
		}
	}
}