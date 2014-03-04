package com.reycogames.powerhour.manager
{
	import com.reycogames.powerhour.data.Playlist;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.media.SoundChannel;

	public class CurrentSongManager
	{		
		public static  var currentSongName:String;
		
		private static var currentPosition:Number;
		private static var CURRENT_PLAYLIST:Playlist;
		private static var alarm:Sound;
		private static var alarmSoundChannel:SoundChannel;
		
		public static function update():void
		{
			currentSongName = "No tracks playing...";
			
			if( (!CURRENT_PLAYLIST && AppModel.selectedPlaylist) || (CURRENT_PLAYLIST && (AppModel.selectedPlaylist.title != CURRENT_PLAYLIST.title)) )
			{
				CURRENT_PLAYLIST = AppModel.selectedPlaylist;
				AppModel.CURRENT_SONG_INDEX = 0;
			}
		}
		
		public static function playNextSong( incrementIndex:Boolean = true ):void
		{
			AppModel.CURRENT_SONG_INDEX++;
			
			stop();
			
			if(AppModel.CURRENT_SONG_INDEX >= AppModel.selectedPlaylist.tracks.length)
				AppModel.CURRENT_SONG_INDEX = 0;
			
			if( AppModel.selectedPlaylist.tracks &&  AppModel.selectedPlaylist.tracks.length > 0 )
			{				
				currentSongName = AppModel.selectedPlaylist.tracks[ AppModel.CURRENT_SONG_INDEX ].name;
				AppModel.CURRENT_SONG = new Sound( new URLRequest(AppModel.selectedPlaylist.tracks[ AppModel.CURRENT_SONG_INDEX ].file) );
				AppModel.CURRENT_SONG_SOUNDCHANNEL = AppModel.CURRENT_SONG.play();
			}
		}
		
		public static function stop():void
		{
			if( AppModel.CURRENT_SONG_SOUNDCHANNEL )
			{
				AppModel.CURRENT_SONG_SOUNDCHANNEL.stop();
				AppModel.CURRENT_SONG_SOUNDCHANNEL = null;
			}
		}
		
		public static function pause():void
		{
			if( AppModel.CURRENT_SONG_SOUNDCHANNEL )
			{
				currentPosition = AppModel.CURRENT_SONG_SOUNDCHANNEL.position;
				AppModel.CURRENT_SONG_SOUNDCHANNEL.stop();
			}
		}
		
		public static function resume():void
		{
			if( AppModel.CURRENT_SONG_SOUNDCHANNEL )
			{
				AppModel.CURRENT_SONG_SOUNDCHANNEL = AppModel.CURRENT_SONG.play( currentPosition );
			}
		}
		
		public static function playAlarm():void
		{
			if( !alarm )
			{
				alarm = AppModel.assetManager.getSound( "alarm" );
			}
			
			alarmSoundChannel = alarm.play(0, 999);
		}
		
		public static function stopAlarm():void
		{
			if(alarmSoundChannel)
			{
				alarmSoundChannel.stop();
				alarmSoundChannel = null;
			}
		}
	}
}