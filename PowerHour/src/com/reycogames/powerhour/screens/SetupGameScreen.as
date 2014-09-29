package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.manager.ImageGenerationManager;
	import com.reycogames.powerhour.manager.NativeDialogsManager;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	import com.reycogames.powerhour.screens.setupgamescreen.ChoosePlaylistButton;
	import com.reycogames.powerhour.screens.setupgamescreen.LengthButton;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayoutData;
	
	import starling.utils.AssetManager;
	
	public class SetupGameScreen extends AbstractScreen
	{
		private var container:LayoutGroup;
		private var lengthButton:LengthButton;
		private var choosePlaylistButton:ChoosePlaylistButton;
		private var startButton:ImageButton;
		private var littleCup:ImageLoader;
		private var startText:ImageLoader;
		
		public function SetupGameScreen()
		{
			super( "SETUP GAME" );
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			ImageGenerationManager.dispose();
			
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
			
			startButton.validate();
			
			startText = new ImageLoader();
			startText.maintainAspectRatio = true;
			startText.source = AppModel.getTexture( "start_text.fw" );
			startText.width = startButton.width * 0.80;
			addChild( startText );
		}
		
		private function startGame():void
		{
			if(AppModel.selectedPlaylist)
				AppModel.navigator.showScreen( AppScreens.TAKE_PHOTO_OR_SKIP_SCREEN );
			else
				NativeDialogsManager.showNoPlaylistSelectedAlert();
		}
		
		override protected function draw():void
		{
			super.draw();
			lengthButton.y = stage.stageHeight * 0.15;
			
			choosePlaylistButton.y = lengthButton.y + lengthButton.height + 40;
			
			var bottomSection:Rectangle = bottomSpace;
			
			startButton.x = (stage.stageWidth - startButton.width) * 0.5;
			startButton.y = bottomSection.y + ((bottomSection.height - startButton.height) * 0.5);
			
			startText.x = (stage.stageWidth - startText.width) * 0.5;
			startText.y = startButton.y + startButton.height + 10;
		}
		
		private function get bottomSpace():Rectangle
		{
			return new Rectangle(0, choosePlaylistButton.y + choosePlaylistButton.height, actualPageHeight, actualPageHeight - (choosePlaylistButton.y + choosePlaylistButton.height));
		}
	}
}