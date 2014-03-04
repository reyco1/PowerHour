package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.data.Playlist;
	import com.reycogames.powerhour.manager.CurrentSongManager;
	import com.reycogames.powerhour.model.AppColors;
	import com.reycogames.powerhour.model.AppFonts;
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.LayoutGroup;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	
	import starling.events.Event;
	
	public class SongLabel extends LayoutGroup
	{
		private var horizontalLayout:HorizontalLayout;
		private var nowPlayingText:CustomLabel;
		private var skipButton:ImageButton;
		private var songText:CustomLabel;
		
		private static var CURRENT_PLAYLIST:Playlist;
		
		public function SongLabel()
		{
			super();
			addEventListener( FeathersEventType.INITIALIZE, handleInitialize );
		}
		
		private function handleInitialize( event:Event ):void
		{
			songText = new CustomLabel( AppFonts.ARIAL_BLACK, AppColors.WHITE, AppModel.LOW_RES ? 30 : 40 );
			songText.text = "TRACK: ";
			addChild( songText );
			
			nowPlayingText = new CustomLabel( AppFonts.ARIAL, AppColors.WHITE, AppModel.LOW_RES ? 30 : 40 );
			nowPlayingText.text = "No tracks playing...";
			addChild( nowPlayingText );
			
			skipButton = new ImageButton( "skip_button.fw", stage.stageWidth * 0.2 );
			skipButton.onTrigger = nextSong;
			addChild( skipButton );
			
			CurrentSongManager.update();
			
			playNextSong();
			
			updateLayout();
		}
		
		public function nextSong():void
		{
			playNextSong();
			updateLayout();
		}
		
		public function stopCurrentSong():void
		{
			CurrentSongManager.stop();
		}
		
		private function playNextSong():void
		{
			CurrentSongManager.playNextSong( false );
			text = CurrentSongManager.currentSongName;
		}
		
		public function set text(value:String):void
		{
			nowPlayingText.text = value;
			updateLayout();	
		}
		
		private function updateLayout():void
		{
			songText.validate();
			nowPlayingText.validate();
			skipButton.validate();
			
			skipButton.x = stage.stageWidth - skipButton.width - 5;
			
			songText.x = 5;
			songText.y = skipButton.y + (( skipButton.height - songText.height ) * 0.5 );
			
			nowPlayingText.x = songText.x + songText.width;
			nowPlayingText.y = skipButton.y + (( skipButton.height - nowPlayingText.height ) * 0.5 );
		}
		
		override public function dispose():void
		{
			stopCurrentSong();
			super.dispose();
		}
	}
}