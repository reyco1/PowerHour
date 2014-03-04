package com.reycogames.powerhour.drawers
{
	import com.reycogames.powerhour.controls.ImageButton;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.manager.ScreenManager;
	
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class LeftDrawer extends ScrollContainer
	{
		private var buttonContainer:ScrollContainer;
		private var managePlaylistButton:ImageButton;
		private var verticalLayout:VerticalLayout;
		private var menulabelImage:ImageButton;
		private var howToPlayButton:ImageButton;
		private var shareButton:ImageButton;
		
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
				AppModel.screenManager.dispatchEventWith(ScreenManager.TOGGLE_LEFT_DRAWER);
			}
			addChild( howToPlayButton );
			
			shareButton = new ImageButton( "share_link.fw", this.width * 0.8 );
			shareButton.onTrigger = function():void
			{
				AppModel.screenManager.dispatchEventWith(ScreenManager.TOGGLE_LEFT_DRAWER);
			}
			addChild( shareButton );
		}
	}
}