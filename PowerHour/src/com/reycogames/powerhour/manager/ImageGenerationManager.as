package com.reycogames.powerhour.manager
{
	import com.leeburrows.encoders.AsyncJPGEncoder;
	import com.leeburrows.encoders.supportClasses.AsyncImageEncoderEvent;
	import com.leeburrows.encoders.supportClasses.IAsyncImageEncoder;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class ImageGenerationManager
	{
		private static var _onProgress:Function;
		private static var _onComplete:Function;
		
		private static var encoder:IAsyncImageEncoder;
		private static var step:int = 0;
		
		public static var image_1:ByteArray;
		public static var image_2:ByteArray;
		
		public static function processImage( bitmap:BitmapData, rate:int = 120 ):void
		{
			if( encoder == null )
			{
				trace("[ImageGenerationManager]", "creating encoder instance");
				encoder = new AsyncJPGEncoder();
			}
			
			encoder.addEventListener(AsyncImageEncoderEvent.PROGRESS, encodeProgressHandler);
			encoder.addEventListener(AsyncImageEncoderEvent.COMPLETE, encodeCompleteHandler);
			
			trace("[ImageGenerationManager]", "encoding begin...");
			encoder.start(bitmap, rate);
		}
		
		private static function encodeProgressHandler( event:AsyncImageEncoderEvent ):void
		{
			
			if(onProgress != null)
				onProgress.call(null, event.percentComplete );
			
			trace("[ImageGenerationManager]", "encoding progress:", Math.floor(event.percentComplete)+"%");
		}
		
		private static function encodeCompleteHandler( event:AsyncImageEncoderEvent ):void
		{
			encoder.removeEventListener(AsyncImageEncoderEvent.PROGRESS, encodeProgressHandler);
			encoder.removeEventListener(AsyncImageEncoderEvent.COMPLETE, encodeCompleteHandler);
			
			trace("[ImageGenerationManager]", "encoding progress: 100% complete");			
			trace("[ImageGenerationManager]", "encoding completed:", encoder.encodedBytes.length+" bytes");
			
			if(step == 0)
			{
				step = 1;
				image_1 = encoder.encodedBytes;
				
				ImageUploadManager.save( image_1, "start" );
			}
			else if (step == 1)
			{
				step = 0;
				image_2 = encoder.encodedBytes;
			}
			
			if(onProgress != null)
				onProgress.call( null, 100 );
			
			if(onComplete != null)
				onComplete.call( null );
		}
		
		public static function get onComplete():Function
		{
			return _onComplete;
		}
		
		public static function set onComplete(value:Function):void
		{
			_onComplete = value;
		}
		
		public static function get onProgress():Function
		{
			return _onProgress;
		}
		
		public static function set onProgress(value:Function):void
		{
			_onProgress = value;
		}	
		
		public static function dispose():void
		{
			if(image_1)
			{
				image_1.clear();
				image_1 = null;
			}
			
			if(image_2)
			{
				image_2.clear();
				image_2 = null;
			}
			
			if(encoder)
			{
				encoder.removeEventListener(AsyncImageEncoderEvent.PROGRESS, encodeProgressHandler);
				encoder.removeEventListener(AsyncImageEncoderEvent.COMPLETE, encodeCompleteHandler);
				encoder.dispose();
			}
			
			step = 0;
			
			trace("[ImageGenerationManager]", 'disposed!' );
		}
	}
}