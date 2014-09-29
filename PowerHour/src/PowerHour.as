package
{
	import com.reycogames.powerhour.ApplicationContainer;
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.manager.CameraManager;
	import com.reycogames.powerhour.manager.NativeDialogsManager;
	import com.reycogames.powerhour.manager.PauseManager;
	import com.reycogames.powerhour.manager.ShareManager;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.utils.GUID;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	
	[SWF(width="640",height="960",frameRate="60",backgroundColor="#F04937")]
	public class PowerHour extends Sprite
	{		
		private var _starling:Starling;
		private var _launchImage:Loader;
		private var _savedAutoOrients:Boolean;
		private var preSplashImage:Bitmap;
		private var preLoadBarImage:Bitmap;
		
		public function PowerHour()
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			NativeDialogsManager.initialize();
			CameraManager.initialize();
			ShareManager.initialize();			
			GUID.initialize();
			
			if(this.stage)
			{
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			
			this.mouseEnabled = this.mouseChildren = false;
			this.showLaunchImage();
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private function showLaunchImage():void
		{
			var filePath:String;
			var isPortraitOnly:Boolean = false;
			
			if(Capabilities.manufacturer.indexOf("iOS") >= 0)
			{
				AppModel.IS_IOS = true;
				
				if(Capabilities.screenResolutionX == 1536 && Capabilities.screenResolutionY == 2048)
				{
					var isCurrentlyPortrait:Boolean = this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? "Default-Portrait@2x.png" : "Default-Landscape@2x.png";
				}
				else if(Capabilities.screenResolutionX == 768 && Capabilities.screenResolutionY == 1024)
				{
					isCurrentlyPortrait = this.stage.orientation == StageOrientation.DEFAULT || this.stage.orientation == StageOrientation.UPSIDE_DOWN;
					filePath = isCurrentlyPortrait ? "Default-Portrait.png" : "Default-Landscape.png";
				}
				else if(Capabilities.screenResolutionX == 640)
				{
					isPortraitOnly = true;
					if(Capabilities.screenResolutionY == 1136)
					{
						filePath = "Default-568h@2x.png";
					}
					else
					{
						filePath = "Default@2x.png";
					}
				}
				else if(Capabilities.screenResolutionX == 320)
				{
					isPortraitOnly = true;
					filePath = "Default.png";
				}
			}
			
			if(filePath)
			{
				var file:File = File.applicationDirectory.resolvePath(filePath);
				if(file.exists)
				{
					var bytes:ByteArray = new ByteArray();
					var stream:FileStream = new FileStream();
					stream.open(file, FileMode.READ);
					stream.readBytes(bytes, 0, stream.bytesAvailable);
					stream.close();
					this._launchImage = new Loader();
					this._launchImage.loadBytes(bytes);
					this.addChild(this._launchImage);
					this._savedAutoOrients = this.stage.autoOrients;
					this.stage.autoOrients = false;
					if(isPortraitOnly)
					{
						this.stage.setOrientation(StageOrientation.DEFAULT);
					}
				}
			}
		}
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			addPreSplashImage();
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			this._starling = new Starling(ApplicationContainer, this.stage);
			this._starling.enableErrorChecking = false;
			this._starling.start();
			this._starling.addEventListener("rootCreated", starling_rootCreatedHandler);			
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private function starling_rootCreatedHandler(event:Object):void
		{
			if(this._launchImage)
			{
				this.removeChild(this._launchImage);
				this._launchImage.unloadAndStop(true);
				this._launchImage = null;
				this.stage.autoOrients = this._savedAutoOrients;
			}
			
			//Remove the splash image
			removeChild(preSplashImage);
			preSplashImage.bitmapData.dispose();
			preSplashImage = null;
			
			// remove load bar image
			removeChild( preLoadBarImage );
			preLoadBarImage.bitmapData.dispose();
			preLoadBarImage = null;
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			var viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}
		
		protected function addPreSplashImage():void
		{
			preSplashImage = new EmbeddedAssets.SPLASH_LOGO_EMBEDDED();
			
			var ratio:Number 	  = preSplashImage.height / preSplashImage.width;
			var newWidth:Number   = stage.stageWidth * 0.6;			
			preSplashImage.width  = newWidth;
			preSplashImage.height = newWidth * ratio;
			
			preSplashImage.x = (stage.stageWidth  - preSplashImage.width)  * 0.5;
			preSplashImage.y = ((stage.stageHeight - preSplashImage.height) * 0.5) - 50;
			
			addChild( preSplashImage );
			
			preLoadBarImage = new EmbeddedAssets.LOAD_BAR_BACKGROUND_EMBEDDED();
			preLoadBarImage.width = stage.stageWidth * 0.65;
			preLoadBarImage.height = 40;
			
			preLoadBarImage.x = (stage.stageWidth  - preLoadBarImage.width)  * 0.5;
			preLoadBarImage.y = stage.stageHeight - preLoadBarImage.height - 15;
			
			addChild( preLoadBarImage );
		}
		
		private function stage_deactivateHandler(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
			
			PauseManager.pause();
		}
		
		private function stage_activateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
			
			PauseManager.resume();
		}
		
	}
}