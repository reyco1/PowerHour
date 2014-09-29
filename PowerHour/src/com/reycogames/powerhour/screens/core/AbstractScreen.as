package com.reycogames.powerhour.screens.core
{
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.PanelScreen;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	
	public class AbstractScreen extends PanelScreen
	{
		private var littleCup:ImageLoader;
		
		public function AbstractScreen( title:String )
		{
			super();
			this.headerProperties.title = title;
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		protected function initializeHandler():void
		{
			this.headerProperties.padding = 25;
			
			littleCup = new ImageLoader();
			littleCup.maintainAspectRatio = true;
			littleCup.smoothing = TextureSmoothing.BILINEAR;
			littleCup.source = AppModel.getTexture( "cup.fw" );
			littleCup.height = AppModel.LOW_RES ? 50 : 75;
			littleCup.touchable = true;
			littleCup.addEventListener( TouchEvent.TOUCH, function( event:TouchEvent ):void
			{
				var touch:Touch = event.getTouch(littleCup);
				if( touch && touch.phase == TouchPhase.BEGAN )
				{
					AppModel.navigator.showScreen(AppScreens.START_SCREEN);
				}
			});
			
			this.headerProperties.rightItems = new <DisplayObject>
				[
					littleCup
				];
			
			this.layout = new AnchorLayout();
		}
	}
}