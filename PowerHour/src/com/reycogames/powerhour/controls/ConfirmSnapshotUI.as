package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.manager.ImageGenerationManager;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.ProcessImageScreen;
	
	import flash.display.BitmapData;
	
	import feathers.controls.LayoutGroup;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	
	import starling.display.Quad;
	
	public class ConfirmSnapshotUI extends LayoutGroup
	{
		private var awesomeButton:ImageButton;
		private var retakeButton:ImageButton;
		private var shareButton:ImageButton;
		private var background:Quad;
		private var bitmapData:BitmapData;
		
		public function ConfirmSnapshotUI( bitmapData:BitmapData )
		{
			super();
			this.bitmapData = bitmapData;
			addEventListener( FeathersEventType.INITIALIZE, handleInitialize );
		}
		
		private function handleInitialize():void
		{
			awesomeButton = new ImageButton( "awesome_button.fw", stage.stageWidth * 0.65 );
			awesomeButton.onTrigger = function():void
			{
				if( AppModel.MINUTES > 0 )
				{
					ImageGenerationManager.processImage( bitmapData );
					AppModel.navigator.showScreen( AppScreens.COUNTDOWN_SCREEN );
				}
				else
				{
					ImageGenerationManager.processImage( bitmapData, 240 );
					PopUpManager.addPopUp( new ProcessImageScreen() );
				}
			};
			addChild( awesomeButton );			
			
			retakeButton  = new ImageButton( "retake_button.fw", stage.stageWidth * 0.3  );
			retakeButton.onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.TAKE_PHOTO_SCREEN );
			};
			addChild( retakeButton );
			
			awesomeButton.validate();
			
			background = new Quad( stage.stageWidth, awesomeButton.height + 20, AppColors.RED_ORANGE );
			addChildAt( background, 0 );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			awesomeButton.validate();
			retakeButton.validate();	
			
			retakeButton.y  = 10;
			awesomeButton.y = 10;
			
			awesomeButton.x = stage.stageWidth - awesomeButton.width - 10;
			retakeButton.x  = 10;
		}
		
		override public function dispose():void
		{
			super.dispose();
			bitmapData = null;
		}
	}
}