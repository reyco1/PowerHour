package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	import com.reycogames.powerhour.screens.setupgamescreen.ChoosePlaylistButton;
	import com.reycogames.powerhour.screens.setupgamescreen.LengthButton;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayoutData;
	
	public class SetupGameScreen extends AbstractScreen
	{
		private var container:LayoutGroup;
		private var lengthButton:LengthButton;
		private var choosePlaylistButton:ChoosePlaylistButton;
		private var startButton:ImageButton;
		private var littleCup:ImageLoader;
		
		public function SetupGameScreen()
		{
			super( "SETUP GAME" );
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			container = new LayoutGroup();
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			lengthButton = new LengthButton();
			addChild( lengthButton );
			
			choosePlaylistButton = new ChoosePlaylistButton();
			addChild( choosePlaylistButton );
			
			startButton = new ImageButton( "cup.fw", stage.stageWidth * .35);
			startButton.onTrigger = startGame;
			addChild( startButton );
		}
		
		private function startGame():void
		{
			AppModel.navigator.showScreen( AppScreens.COUNTDOWN_SCREEN );
		}
		
		/*
		private function takePhoto():void
		{
			Camera.instance.setPresetMode( CameraMode.PRESET_PHOTO );			
			Camera.instance.setDevice( "0" );
			Camera.instance.addEventListener( CameraDataEvent.CAPTURED_IMAGE, capturedImageHandler, false, 0, true );
			Camera.instance.captureImage(false);
		}
		
		
		protected function capturedImageHandler(event:CameraDataEvent):void
		{			
			var bitmapData:BitmapData = new BitmapData(event.data.width, event.data.height);
			bitmapData.draw( event.data );
			
			var texture:Texture = Texture.fromBitmapData( bitmapData );
			var image:ImageLoader = new ImageLoader();
			image.maintainAspectRatio = true;
			image.source = texture;
			image.width = stage.stageWidth;
			addChild( image );
		}
		*/
		
		override protected function draw():void
		{
			super.draw();
			lengthButton.y = stage.stageHeight * 0.15;
			
			choosePlaylistButton.y = lengthButton.y + lengthButton.height + 40;
			
			var bottomSection:Rectangle = bottomSpace;
			
			startButton.x = (stage.stageWidth - startButton.width) * 0.5;
			startButton.y = bottomSection.y + ((bottomSection.height - startButton.height) * 0.5);
		}
		
		private function get bottomSpace():Rectangle
		{
			return new Rectangle(0, choosePlaylistButton.y + choosePlaylistButton.height, actualPageHeight, actualPageHeight - (choosePlaylistButton.y + choosePlaylistButton.height));
		}
	}
}