package com.reycogames.powerhour
{
	import com.reycogames.powerhour.data.EmbeddedAssets;
	import com.reycogames.powerhour.drawers.LeftDrawer;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	import com.reycogames.powerhour.manager.ScreenManager;
	import com.reycogames.powerhour.screens.SplashScreen;
	import com.reycogames.powerhour.themes.PowerHourTheme;
	
	import feathers.controls.Drawers;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	
	public class ApplicationContainer extends Drawers
	{
		public function ApplicationContainer()
		{
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler( event:Event ):void
		{
			EmbeddedAssets.initialize();
			
			new PowerHourTheme();			
			content = new SplashScreen( handleLoadComplete );
			
			AppModel.LOW_RES = stage.stageWidth < 720;
		}
		
		private function handleLoadComplete():void
		{
			AppModel.screenManager = new ScreenManager();
			content = AppModel.screenManager;
			
			leftDrawer = new LeftDrawer();
			leftDrawerToggleEventType = ScreenManager.TOGGLE_LEFT_DRAWER;
			
			AppModel.navigator.showScreen( AppScreens.START_SCREEN );
		}
	}
}