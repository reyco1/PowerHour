package com.reycogames.powerhour.manager
{
	import com.distriqt.extension.camera.Camera;
	import com.distriqt.extension.camera.CameraMode;
	import com.distriqt.extension.camera.CameraParameters;
	import com.distriqt.extension.camera.CaptureDevice;
	import com.distriqt.extension.camera.events.CameraEvent;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	import feathers.controls.ImageLoader;
	
	import starling.core.Starling;
	import starling.textures.Texture;

	public class CameraManager
	{
		public  static var initialized:Boolean = false;
		
		private static var lastFrameProcessed:Number;
		private static var bitmapData:BitmapData;
		private static var cameraTexture:starling.textures.Texture;
		private static var video:ImageLoader;
		private static var videoData:ByteArray;
		private static var snapshotTexture:starling.textures.Texture;
		private static var snapshot:ImageLoader;
		
		public static  var height:Number;
		
		public static function initialize():void
		{
			Camera.init( AppModel.DISTRIQT_DEV_KEY );
		}
		
		public static function dispose():void
		{
			stopVideoCapture();
			Camera.init( AppModel.DISTRIQT_DEV_KEY );
		}
		
		public static function init():void
		{
			if (Camera.isSupported)
			{
				initialized = true;
				
				var devices:Array = Camera.instance.getAvailableDevices();
				var device:CaptureDevice = devices[0];
				
				var mode:CameraMode = new CameraMode( CameraMode.PRESET_640x480 );
				
				var options:CameraParameters = new CameraParameters();
				options.deviceId 			= device.id;
				options.enableFrameBuffer 	= true;
				options.cameraMode 			= mode;
				
				Camera.instance.initialise( options );
				
				if(!videoData)
					videoData = new ByteArray();
				
				if(!bitmapData)
					bitmapData = new BitmapData( 640, 480, true );
				
				if(!cameraTexture)
					cameraTexture = starling.textures.Texture.fromBitmapData( bitmapData, true, true );
				else
					flash.display3D.textures.Texture( cameraTexture.base ).uploadFromBitmapData( bitmapData );
				
				var newWidth:Number = Starling.current.nativeStage.stageWidth;
				
				video = new ImageLoader();
				video.maintainAspectRatio = true;
				video.source = cameraTexture;
				video.height = newWidth;
				video.rotation = 90 * Math.PI / 180;
				video.x = AppModel.STARLING_SATGE.stageWidth;
				video.validate();
			}
		}
		
		public static function getVideo():ImageLoader
		{
			video.validate();
			return video;
		}
		
		public static function getSnapShot():Object
		{
			var imageBitmapData:BitmapData = new BitmapData(bitmapData.height, bitmapData.width);
			
			var matrix:Matrix = new Matrix();
			matrix.translate(-bitmapData.width * 0.5, -bitmapData.height * 0.5);
			matrix.rotate(90 * (Math.PI / 180));
			matrix.translate(bitmapData.height * 0.5, bitmapData.width * 0.5);
			
			imageBitmapData.draw( bitmapData, matrix );
			
			if(!snapshotTexture)
				snapshotTexture = starling.textures.Texture.fromBitmapData( imageBitmapData );
			else
				flash.display3D.textures.Texture( snapshotTexture.base ).uploadFromBitmapData( imageBitmapData );
			
			if(!snapshot) 
			{
				snapshot = new ImageLoader();
				snapshot.maintainAspectRatio = true;
				snapshot.source = snapshotTexture;
			}
			
			return {snapshot:snapshot, bitmapData:imageBitmapData};
		}
		
		public static function startVideoCapture():void
		{
			Camera.instance.addEventListener( CameraEvent.VIDEO_FRAME, videoFrameHandler, false, 0, true );
		}
		
		public static function stopVideoCapture():void
		{
			Camera.instance.removeEventListener( CameraEvent.VIDEO_FRAME, videoFrameHandler );
		}
		
		protected static function videoFrameHandler(event:CameraEvent):void
		{			
			var frame:Number = Camera.instance.receivedFrames;
			
			if (frame != lastFrameProcessed)
			{
				Camera.instance.getFrameBuffer( videoData );
				
				var rect:Rectangle = new Rectangle( 0, 0, Camera.instance.width, Camera.instance.height );
				
				if (bitmapData.width != Camera.instance.width || bitmapData.height != Camera.instance.height)
				{
					bitmapData = new BitmapData( Camera.instance.width, Camera.instance.height, true );
					flash.display3D.textures.Texture(cameraTexture.base).uploadFromBitmapData(bitmapData);
				}
				
				try
				{
					bitmapData.setPixels( rect, videoData );
					flash.display3D.textures.Texture(cameraTexture.base).uploadFromBitmapData(bitmapData);
				}
				catch (e:Error)
				{
					trace( e.message );
				}
				
				videoData.clear();
				lastFrameProcessed = frame;
			}
		}
	}
}