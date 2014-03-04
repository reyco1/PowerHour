package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	public class SplashScreen extends Screen
	{
		public static var LOAD_COMPLETE:String = "SplashScreen.LOAD_COMPLETE";
		
		private var logoImage:ImageLoader;
		public var onLoadComplete:Function;
		
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
			
			AppModel.assetManager = new AssetManager();
			AppModel.assetManager.verbose = true;
			AppModel.assetManager.enqueue( EmbeddedAssets );
			AppModel.assetManager.enqueue( "assets/images/powerhour.png" );
			AppModel.assetManager.enqueue( "assets/images/powerhour.xml" );
			AppModel.assetManager.enqueue( "assets/sounds/alarm.mp3" );
			AppModel.assetManager.loadQueue( onAssetLoadProgress );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			logoImage.validate();
			logoImage.x = (stage.stageWidth  - logoImage.width)  * 0.5;
			logoImage.y = (stage.stageHeight - logoImage.height) * 0.5;
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
		}
	}
}