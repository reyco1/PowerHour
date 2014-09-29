package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.core.SharePopup;
	
	import feathers.controls.LayoutGroup;
	import feathers.core.PopUpManager;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class FinalScreenControls extends LayoutGroup
	{
		private var shareButton:ImageButton;
		private var playAgainButton:ImageButton;
		private var background:Quad;
		private var sharePopup:SharePopup;
		public function FinalScreenControls()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			shareButton = new ImageButton( 'share_bt_lg', AppModel.STARLING_SATGE.stageWidth * 0.47 );
			shareButton.onTrigger = function():void
			{
				sharePopup = new SharePopup( AppModel.processedImageData.picture_url );
				PopUpManager.addPopUp( sharePopup, true, true, function():DisplayObject
				{
					var quad:Quad = new Quad(100, 100, 0x000000);
					quad.alpha = 0.75;
					quad.touchable = true;
					quad.addEventListener( TouchEvent.TOUCH, function(e:TouchEvent):void
					{
						var touch:Touch = e.getTouch(quad);
						if( touch && touch.phase == TouchPhase.BEGAN )
						{
							PopUpManager.removePopUp( sharePopup );
						}
					});
					return quad;
				});
			};
			shareButton.validate();
			addChild( shareButton );
			
			playAgainButton = new ImageButton( 'play_again', AppModel.STARLING_SATGE.stageWidth * 0.47 );
			playAgainButton.onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.START_SCREEN );
			};
			addChild( playAgainButton );
			
			playAgainButton.validate();
			
			background = new Quad( stage.stageWidth, playAgainButton.height + 20, AppColors.RED_ORANGE );
			addChildAt( background, 0 );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			shareButton.validate();
			playAgainButton.validate();
			
			shareButton.y  = 10;
			playAgainButton.y = 10;
			
			playAgainButton.x = stage.stageWidth - playAgainButton.width - 10;
			shareButton.x  = 10;
		}
	}
}