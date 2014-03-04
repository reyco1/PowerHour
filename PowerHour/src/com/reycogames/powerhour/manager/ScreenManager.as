package com.reycogames.powerhour.manager
{
	import com.reycogames.powerhour.controls.DrawerThumb;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.screens.AlarmScreen;
	import com.reycogames.powerhour.screens.CountdownScreen;
	import com.reycogames.powerhour.screens.PlaylistScreen;
	import com.reycogames.powerhour.screens.SetupGameScreen;
	import com.reycogames.powerhour.screens.StartScreen;
	import com.reycogames.powerhour.screens.TakePhotoScreen;
	import com.reycogames.powerhour.screens.core.ScreenNavigatorWithHistory;
	import com.reycogames.powerhour.screens.playlistscreen.PlaylistView;
	
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.events.Event;
	
	public class ScreenManager extends ScrollContainer
	{
		public static const TOGGLE_LEFT_DRAWER:String = "toggleLeftDrawer";
		
		private var screens:Vector.<Object>;
		private var screenTransitionManager:ScreenSlidingStackTransitionManager;
		private var drawerThumb:DrawerThumb;
		
		public function ScreenManager()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler( event:Event ):void
		{
			screens = new Vector.<Object>();
			
			screens.push( {id:AppScreens.START_SCREEN, screen:StartScreen} );
			screens.push( {id:AppScreens.SETUP_GAME_SCREEN, screen:SetupGameScreen} );
			screens.push( {id:AppScreens.PLAYLIST_SCREEN, screen:PlaylistScreen} );
			screens.push( {id:AppScreens.PLAY_LIST_VIEW, screen:PlaylistView} );
			screens.push( {id:AppScreens.COUNTDOWN_SCREEN, screen:CountdownScreen} );
			screens.push( {id:AppScreens.ALARM_SCREEN, screen:AlarmScreen} );
			screens.push( {id:AppScreens.TAKE_PHOTO_SCREEN, screen:TakePhotoScreen} );
			
			AppModel.navigator = new ScreenNavigatorWithHistory();
			
			for (var a:int = 0; a < screens.length; a++) 
				AppModel.navigator.addScreen( screens[a].id, new ScreenNavigatorItem( screens[a].screen ) );
			
			AppModel.navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, handleNavigationChange);			
			screenTransitionManager = new ScreenSlidingStackTransitionManager( AppModel.navigator );
			
			addChild( AppModel.navigator );
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if( event.keyCode == Keyboard.BACK )
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				AppModel.navigator.goBack();
			}
		}
		
		private function handleNavigationChange(event:starling.events.Event):void
		{
			var activeScreenId:String = AppModel.navigator.activeScreenID;
			
			switch( event.type )
			{
				case FeathersEventType.TRANSITION_COMPLETE:
					
					if(!drawerThumb 
						&& AppModel.navigator.activeScreenID != AppScreens.START_SCREEN
						&& AppModel.navigator.activeScreenID != AppScreens.ALARM_SCREEN)
					{
						drawerThumb = new DrawerThumb();
						drawerThumb.scaleX = drawerThumb.scaleY = AppModel.LOW_RES ? 1 : 1.25;
						drawerThumb.onTrigger = onDrawerPressed;
						addChild( drawerThumb );
						
						drawerThumb.validate();
					}
					
					if(activeScreenId == AppScreens.START_SCREEN )
					{
						if(drawerThumb)
							drawerThumb.visible = false;
					}
					else
					{
						if(drawerThumb)
							drawerThumb.visible = true;
					}
					
					break;
			}
		}
		
		private function onDrawerPressed():void
		{
			dispatchEvent(new Event(ScreenManager.TOGGLE_LEFT_DRAWER));
		}
	}
}