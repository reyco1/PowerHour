package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.manager.CurrentSongManager;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	
	public class AlarmScreen extends PanelScreen
	{
		private var logoImage:ImageLoader;
		private var drinkImage:ImageLoader;
		private var container:LayoutGroup;
		private var timer:uint;
		
		public function AlarmScreen()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler( event:Event ):void
		{
			var anchorLayout:AnchorLayout = new AnchorLayout();
			this.layout = anchorLayout;
			
			var contianerLayout:VerticalLayout = new VerticalLayout();
			contianerLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			contianerLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			contianerLayout.gap = 25;
			
			container = new LayoutGroup();
			container.layout = contianerLayout;		
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			drinkImage = new ImageLoader();
			drinkImage.smoothing = TextureSmoothing.BILINEAR;
			drinkImage.source = AppModel.assetManager.getTexture( "drink_text.fw" );
			drinkImage.maintainAspectRatio = true;
			drinkImage.textureScale = 0.5;
			drinkImage.width = stage.stageWidth * 0.75;
			container.addChild( drinkImage );
			
			logoImage = new ImageLoader();
			logoImage.smoothing = TextureSmoothing.BILINEAR;
			logoImage.source = EmbeddedAssets.LARGE_CUP;
			logoImage.maintainAspectRatio = true;
			logoImage.textureScale = 0.5;
			logoImage.width = stage.stageWidth * 0.75;
			container.addChild( logoImage );
			
			CurrentSongManager.playAlarm();
			
			container.touchable = true;
			container.addEventListener(TouchEvent.TOUCH, handleClicked);
			
			timer = setTimeout( determineNextScreen, 6000 );
		}
		
		private function handleClicked( event:TouchEvent ):void
		{
			clearTimeout( timer );
			
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				container.removeEventListener(TouchEvent.TOUCH, handleClicked); 
				CurrentSongManager.stopAlarm();
				determineNextScreen();				
			}			
		}
		
		private function determineNextScreen():void
		{
			var nextScreen:String = AppModel.MINUTES == 0 ? AppScreens.TAKE_PHOTO_OR_SKIP_SCREEN : AppScreens.COUNTDOWN_SCREEN;			
			AppModel.navigator.showScreen( nextScreen );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			logoImage.invalidate();
			drinkImage.invalidate();
			container.invalidate();		
		}
		
		override public function dispose():void
		{
			clearTimeout( timer );
			CurrentSongManager.stopAlarm();
			super.dispose();
		}
	}
}