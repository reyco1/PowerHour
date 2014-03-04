package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;
	import starling.textures.TextureSmoothing;
	
	public class StartScreen extends PanelScreen
	{
		private var logoImage:ImageLoader;
		private var startGameButton:ImageButton;
		private var shareButton:ImageButton;
		private var container:LayoutGroup;
		private var verticalLayout:VerticalLayout;
		public function StartScreen()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler(event:Event):void
		{
			this.layout = new AnchorLayout();
			
			verticalLayout				 		= new VerticalLayout();
			verticalLayout.verticalAlign 		= VerticalLayout.VERTICAL_ALIGN_TOP;
			verticalLayout.horizontalAlign 		= VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			container = new LayoutGroup();
			container.layout = verticalLayout;
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			logoImage = new ImageLoader();
			logoImage.smoothing = TextureSmoothing.BILINEAR;
			logoImage.source = AppModel.getTexture( "simple_logo.fw" );
			logoImage.maintainAspectRatio = true;
			logoImage.textureScale = 0.5;
			logoImage.width = stage.stageWidth * 0.4;
			container.addChild( logoImage );
			
			startGameButton = new ImageButton( "start_game_button.fw", stage.stageWidth * 0.95 );
			startGameButton.onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.SETUP_GAME_SCREEN );
			}
			container.addChild( startGameButton );
			
			shareButton = new ImageButton( "share_button.fw", stage.stageWidth * 0.4 );
			container.addChild( shareButton );
		}
		
		override protected function draw():void
		{
			super.draw();
			verticalLayout.gap = (container.height - (header.height * 2) - ( logoImage.height + startGameButton.height + shareButton.height )) / 2;
			container.validate();
		}
	}
}