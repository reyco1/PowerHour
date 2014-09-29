package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.manager.CurrentSongManager;
	import com.reycogames.powerhour.manager.NativeDialogsManager;
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
		private var shotsRemainingContianer:LayoutGroup;
		public  var onPause:Function;
		
		public function PauseStopControls()
		{
			addEventListener( FeathersEventType.INITIALIZE, handleInitialize );
		}
		
		private function handleInitialize( event:Event ):void
		{
			pauseButton = new ImageButton( "pause_button.fw", stage.stageWidth * 0.3 );
			pauseButton.onTrigger = function():void
			{
				PauseManager.toggle;
				
				if(onPause != null)
					onPause.call();
			};
			addChild( pauseButton );
			
			var containerLayout:VerticalLayout = new VerticalLayout();
			containerLayout.gap = -25
			containerLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			containerLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			
			shotsRemainingContianer = new LayoutGroup();
			shotsRemainingContianer.layout = containerLayout;
			addChild( shotsRemainingContianer );			
			
			shotsLeftlabel = new CustomLabel( AppFonts.ARIAL_BLACK, AppColors.DARK_RED_ORANGE, 100 );
			shotsLeftlabel.text = AppModel.MINUTES < 10 ? "0" + AppModel.MINUTES.toString() : AppModel.MINUTES.toString();
			shotsRemainingContianer.addChild( shotsLeftlabel );
			
			var subText:CustomLabel = new CustomLabel( AppFonts.ARIAL, AppColors.WHITE, 20 );
			subText.text = "SHOTS LEFT";
			shotsRemainingContianer.addChild( subText );
			
			stopButton = new ImageButton( "save_button.fw", stage.stageWidth * 0.3 );
			stopButton.onTrigger = showAreYouSureDialog;
			addChild( stopButton );
		}
		
		private function showAreYouSureDialog():void
		{
			NativeDialogsManager.showAreYouSureDialog( gotoMainScreen );
		}
		
		private function gotoMainScreen():void
		{
			CurrentSongManager.stop();
			AppModel.MINUTES = 60;
			AppModel.navigator.showScreen( AppScreens.START_SCREEN );
		}
		
		override protected function draw():void
		{
			super.draw();
			
			pauseButton.validate();
			stopButton.validate();
			shotsRemainingContianer.validate();
			
			stopButton.x = stage.stageWidth - stopButton.width;
			
			shotsRemainingContianer.y = -30
			shotsRemainingContianer.x = (stage.stageWidth - shotsLeftlabel.width) * 0.5
		}
	}
}