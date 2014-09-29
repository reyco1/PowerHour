package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.manager.CameraManager;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.ProgressBar;
	import feathers.controls.Screen;
	import feathers.display.Scale9Image;
	import feathers.events.FeathersEventType;
	import feathers.textures.Scale9Textures;
	
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class SplashScreen extends Screen
	{
		public static var LOAD_COMPLETE:String = "SplashScreen.LOAD_COMPLETE";
		
		private var logoImage:ImageLoader;
		public var onLoadComplete:Function;
		private var progress:ProgressBar;
		
		public function SplashScreen( onLoadComplete:Function )
		{
			this.onLoadComplete = onLoadComplete;
			
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler( event:Event ):void
		{
			logoImage = new ImageLoader();
			logoImage.smoothing = TextureSmoothing.BILINEAR;
			logoImage.source = EmbeddedAssets.SPLASH_LOGO;
			logoImage.maintainAspectRatio = true;
			logoImage.textureScale = 0.5;
			logoImage.width = stage.stageWidth * 0.6;
			addChild( logoImage );
			
			progress = new ProgressBar();
			progress.width = stage.stageWidth * 0.65;
			progress.height = 40;
			progress.minimum = 0;
			progress.maximum = 100;
			addChild( progress );
			
			var texture:Texture = EmbeddedAssets.LOAD_BAR_BACKGROUND;
			var rect:Rectangle = new Rectangle( 7, 4, 345, 12 );
			var textures:Scale9Textures = new Scale9Textures( texture, rect );
			
			var backgroundSkin:Scale9Image = new Scale9Image( textures );
			backgroundSkin.width = stage.stageWidth * 0.65;
			progress.backgroundSkin = backgroundSkin;
			
			AppModel.assetManager = new AssetManager();
			AppModel.assetManager.verbose = true;
			AppModel.assetManager.enqueue( EmbeddedAssets );
			AppModel.assetManager.enqueue( "assets/images/powerhour.png" );
			AppModel.assetManager.enqueue( "assets/images/powerhour.xml" );
			AppModel.assetManager.enqueue( "assets/sounds/alarm.mp3" );
			AppModel.assetManager.enqueue( "assets/sounds/shutterSound.mp3" );
			AppModel.assetManager.loadQueue( onAssetLoadProgress );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			logoImage.validate();
			logoImage.x = (stage.stageWidth  - logoImage.width)  * 0.5;
			logoImage.y = ((stage.stageHeight - logoImage.height) * 0.5) - 50;
			
			progress.validate();
			progress.x = (stage.stageWidth  - progress.width)  * 0.5;
			progress.y = stage.stageHeight - progress.height - 15;
			
			if(!CameraManager.initialized)
				CameraManager.init();
		}
		
		private function onAssetLoadProgress( n:Number ):void
		{
			if(n == 1)
			{
				if(onLoadComplete != null)
				{
					onLoadComplete.call();
				}
			}
			
			progress.value = n * 100;
		}
	}
}