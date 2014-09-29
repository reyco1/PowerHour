package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.CountDownCup;
	import com.reycogames.powerhour.controls.PauseStopControls;
	import com.reycogames.powerhour.controls.SongLabel;
	import com.reycogames.powerhour.manager.AppTimer;
	import com.reycogames.powerhour.manager.PauseManager;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	import com.reycogames.powerhour.screens.countdownscreen.PottyBreakView;
	import com.reycogames.powerhour.screens.playlistscreen.FileBrowserPopup;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
	import feathers.core.PopUpManager;
	import feathers.events.FeathersEventType;
	import feathers.layout.AnchorLayoutData;
	
	import starling.events.Event;
	
	public class CountdownScreen extends AbstractScreen
	{
		private var container:LayoutGroup;
		private var songLabel:SongLabel;
		private var logoImage:ImageLoader;
		private var countdownCup:CountDownCup;
		private var pauseStopControls:PauseStopControls;
		
		public function CountdownScreen()
		{
			super("COUNT DOWN!");
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		
		private function initializeHandler( event:Event ):void
		{
			super.initialize();
			
			container = new LayoutGroup();
			container.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			addChild( container );
			
			songLabel = new SongLabel();
			addChild( songLabel );				
			
			countdownCup = new CountDownCup();
			addChild( countdownCup );
			
			pauseStopControls = new PauseStopControls();
			pauseStopControls.onPause = showPottyBreakPopup;
			addChild( pauseStopControls );
			
			AppTimer.init( true );			
			countdownCup.text = AppTimer.seconds;
			
			AppTimer.update = function():void
			{
				countdownCup.text = AppTimer.seconds;
			}
		}
		
		private function showPottyBreakPopup():void
		{
			PauseManager.pause();
			
			var popup:PottyBreakView = new PottyBreakView();
			PopUpManager.addPopUp( popup, true, true );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			countdownCup.invalidate();
			
			countdownCup.x = (this.container.width  - countdownCup.width)  * 0.5;
			countdownCup.y = (this.container.height - countdownCup.height) * 0.35;
			
			pauseStopControls.invalidate();
			
			pauseStopControls.x = 0;
			pauseStopControls.y = this.container.height - pauseStopControls.height - 10;
		}
		
		override public function dispose():void
		{
			AppTimer.clear();
			super.dispose();
		}
	}
}