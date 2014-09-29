package com.reycogames.powerhour.drawers
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.manager.ScreenManager;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.core.SharePopup;
	
	import flash.desktop.NativeApplication;
	
	import feathers.controls.ScrollContainer;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class LeftDrawer extends ScrollContainer
	{
		private var buttonContainer:ScrollContainer;
		private var managePlaylistButton:ImageButton;
		private var verticalLayout:VerticalLayout;
		private var menulabelImage:ImageButton;
		private var howToPlayButton:ImageButton;
		private var shareButton:ImageButton;
		private var exitButton:ImageButton;
		private var homeButton:ImageButton;
		private var sharePopup:SharePopup;
		
		public function LeftDrawer()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler(event:Event):void
		{
			this.backgroundSkin = new Quad( 10, 10, AppColors.DARK_GOLD );
			this.width = stage.stageWidth * 0.4;
			
			verticalLayout 					= new VerticalLayout();
			verticalLayout.verticalAlign 	= VerticalLayout.VERTICAL_ALIGN_TOP;
			verticalLayout.horizontalAlign 	= VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			verticalLayout.paddingTop		= 35;
			verticalLayout.gap				= 100;
			
			layout 							= verticalLayout;
			
			menulabelImage = new ImageButton( "menu_label.fw", this.width * 0.5  );
			addChild( menulabelImage );
			
			homeButton = new ImageButton( "home_link.fw", this.width * 0.8 );
			homeButton.onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.START_SCREEN );
				AppModel.screenManager.dispatchEventWith(ScreenManager.TOGGLE_LEFT_DRAWER);
			}
			addChild( homeButton );
			
			managePlaylistButton = new ImageButton( "manage_playlist_link.fw", this.width * 0.8 );
			managePlaylistButton.onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.PLAYLIST_SCREEN );
				AppModel.screenManager.dispatchEventWith(ScreenManager.TOGGLE_LEFT_DRAWER);
			}
			addChild( managePlaylistButton );
			
			howToPlayButton = new ImageButton( "how_to_play_link.fw", this.width * 0.8 );
			howToPlayButton.onTrigger = function():void
			{
				AppModel.navigator.showScreen( AppScreens.HOW_TO_PLAY_SCREEN );
				AppModel.screenManager.dispatchEventWith(ScreenManager.TOGGLE_LEFT_DRAWER);
			}
			addChild( howToPlayButton );
			
			shareButton = new ImageButton( "share_link.fw", this.width * 0.8 );
			shareButton.onTrigger = function():void
			{
				sharePopup = new SharePopup();
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
				AppModel.screenManager.dispatchEventWith(ScreenManager.TOGGLE_LEFT_DRAWER);
			}
			addChild( shareButton );
			
			exitButton = new ImageButton( "exit_link.fw", this.width * 0.8 );
			exitButton.onTrigger = function():void
			{
				NativeApplication.nativeApplication.exit();
			}
			addChild( exitButton );
		}
	}
}