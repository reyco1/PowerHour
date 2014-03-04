package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.manager.PauseManager;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	
	import feathers.controls.LayoutGroup;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	
	import starling.events.Event;

	public class PauseStopControls extends LayoutGroup
	{
		private var pauseButton:ImageButton;
		private var stopButton:ImageButton;
		private var shotsLeftlabel:CustomLabel;
		private var shoteRemainingContianer:LayoutGroup;
		public function PauseStopControls()
		{
			addEventListener( FeathersEventType.INITIALIZE, handleInitialize );
		}
		
		private function handleInitialize( event:Event ):void
		{
			pauseButton = new ImageButton( "pause_button.fw", stage.stageWidth * 0.3 );
			pauseButton.onTrigger = PauseManager.toggle;
			addChild( pauseButton );
			
			var containerLayout:VerticalLayout = new VerticalLayout();
			containerLayout.gap = -25
			containerLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			containerLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			shoteRemainingContianer = new LayoutGroup();
			shoteRemainingContianer.layout = containerLayout;
			addChild( shoteRemainingContianer );			
			
			shotsLeftlabel = new CustomLabel( AppFonts.ARIAL_BLACK, AppColors.DARK_RED_ORANGE, 100 );
			shotsLeftlabel.text = AppModel.MINUTES.toString();
			shoteRemainingContianer.addChild( shotsLeftlabel );
			
			var subText:CustomLabel = new CustomLabel( AppFonts.ARIAL, AppColors.WHITE, 20 );
			subText.text = "SHOTS LEFT";
			shoteRemainingContianer.addChild( subText );
			
			stopButton = new ImageButton( "save_button.fw", stage.stageWidth * 0.3 );
			stopButton.onTrigger = gotoMainScreen;
			addChild( stopButton );
		}
		
		private function gotoMainScreen():void
		{
			AppModel.navigator.showScreen( AppScreens.START_SCREEN );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			pauseButton.validate();
			stopButton.validate();
			shoteRemainingContianer.validate();
			
			stopButton.x = stage.stageWidth - stopButton.width;
			
			shoteRemainingContianer.y = -30
			shoteRemainingContianer.x = (stage.stageWidth - shotsLeftlabel.width) * 0.5
		}
	}
}