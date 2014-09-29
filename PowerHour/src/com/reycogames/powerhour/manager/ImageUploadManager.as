package com.reycogames.powerhour.manager
{
	import com.reycogames.powerhour.utils.GUID;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class ImageUploadManager
	{
		private static const CONTENT_TYPE:String 		= "application/octet-stream";
		public  static const URL:String 				= "http://clients.contentcreators.at/powerhour/send";
		public  static var   onUploadComplete:Function	= null;
		public  static var   onUploadFail:Function		= null;
		private static var   startTime:int;		
		
		public static function save(imageFile:ByteArray, phase:String):void
		{
			var urlVars:URLVariables 	= new URLVariables();
			urlVars.phase 				= phase;
			urlVars.user  				= GUID.ID;
			
			var sendHeader:URLRequestHeader = new URLRequestHeader("Content-type", CONTENT_TYPE);
			var sendLoader:URLLoader = new URLLoader();
			var sendReq:URLRequest = new URLRequest( URL + "?" + urlVars.toString() );	
			
			sendReq.requestHeaders.push(sendHeader);
			sendReq.method = URLRequestMethod.POST;
			sendReq.data = imageFile;
			
			sendLoader.addEventListener(Event.COMPLETE, onImageUploaded);
			sendLoader.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			sendLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError );
			
			trace('[ImageUploadManager]', 'uploading image', sendReq.url);	
			sendLoader.load(sendReq);
			
			startTime = getTimer();
		}
		
		protected static function handleError(event:*):void
		{
			trace('[ImageUploadManager]', 'upload error', 'total time:'+(getTimer() - startTime)+'ms', event.text);
			if( onUploadFail != null )
				onUploadFail.call();
		}
		
		protected static function onImageUploaded( event:Event ):void
		{
			trace('[ImageUploadManager]', 'uploaded', 'total time:'+(getTimer() - startTime)+'ms');
			if( onUploadComplete != null )
				onUploadComplete.call( null, event );
		}
		
		public static function dispose():void
		{
			onUploadComplete = null;
			onUploadFail = null;
		}
	}
}