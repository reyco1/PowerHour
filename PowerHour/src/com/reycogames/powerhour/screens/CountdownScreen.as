package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.controls.CountDownCup;
	import com.reycogames.powerhour.controls.PauseStopControls;
	import com.reycogames.powerhour.controls.SongLabel;
	import com.reycogames.powerhour.manager.GameTimer;
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.LayoutGroup;
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
			addChild( pauseStopControls );
			
			GameTimer.init( true );			
			countdownCup.text = GameTimer.seconds;
			
			GameTimer.update = function():void
			{
				countdownCup.text = GameTimer.seconds;
			}
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
			GameTimer.clear();
			super.dispose();
		}
	}
}