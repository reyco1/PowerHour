package com.reycogames.powerhour.manager
{
	import com.reycogames.powerhour.data.Playlist;
	import com.reycogames.powerhour.model.AppModel;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;

	public class CurrentSongManager
	{		
		public static  var currentSongName:String;
		public static  var paused:Boolean = false;
		
		public static var currentPosition:Number;
		public static var CURRENT_PLAYLIST:Playlist;
		public static var alarm:Sound;
		public static var alarmSoundChannel:SoundChannel;
		
		public static function update():void
		{
			currentSongName = "No tracks playing...";
			
			if(paused)
			{
				trace('[CurrentSongManager]', 'was paused, resuming');
				currentSongName = CURRENT_PLAYLIST.tracks[ AppModel.CURRENT_SONG_INDEX ].name;
				trace('[CurrentSongManager]', 'set name to', currentSongName);
				resume();
				return;
			}
			
			if( (!CURRENT_PLAYLIST && AppModel.selectedPlaylist) || (CURRENT_PLAYLIST && (AppModel.selectedPlaylist.title != CURRENT_PLAYLIST.title)) )
			{
				trace('[CurrentSongManager]', 'no playlist selected or playlist selected but no song selected');
				CURRENT_PLAYLIST = AppModel.selectedPlaylist;
				AppModel.CURRENT_SONG_INDEX = -1;
				playNextSong();
			}
		}
		
		public static function playNextSong():void
		{
			trace('[CurrentSongManager]', 'playing next song');
			
			if( !paused )
			{
				AppModel.CURRENT_SONG_INDEX++;
				
				trace('[CurrentSongManager]', 'the song index is', AppModel.CURRENT_SONG_INDEX);
				
				stop();
				
				if(AppModel.CURRENT_SONG_INDEX >= AppModel.selectedPlaylist.tracks.length)
				{
					trace('[CurrentSongManager]', 'reseting index to 0 since we reached the last of the playlist');
					AppModel.CURRENT_SONG_INDEX = 0;
				}
				
				if( AppModel.selectedPlaylist.tracks &&  AppModel.selectedPlaylist.tracks.length > 0 )
				{				
					currentSongName = AppModel.selectedPlaylist.tracks[ AppModel.CURRENT_SONG_INDEX ].name;
					trace('[CurrentSongManager]', 'setting song name to', currentSongName);
					AppModel.CURRENT_SONG = new Sound( new URLRequest(AppModel.selectedPlaylist.tracks[ AppModel.CURRENT_SONG_INDEX ].file) );
					AppModel.CURRENT_SONG_SOUNDCHANNEL = AppModel.CURRENT_SONG.play();
					trace('[CurrentSongManager]', 'song starting');
				}
			}
			else
			{
				resume();
			}
		}
		
		public static function stop():void
		{
			if( AppModel.CURRENT_SONG_SOUNDCHANNEL )
			{
				trace('[CurrentSongManager]', 'stopping current song');
				AppModel.CURRENT_SONG_SOUNDCHANNEL.stop();
				AppModel.CURRENT_SONG_SOUNDCHANNEL = null;
			}
		}
		
		public static function pause():void
		{
			if( AppModel.CURRENT_SONG_SOUNDCHANNEL )
			{
				trace('[CurrentSongManager]', 'pausing current song');
				paused = true;
				currentPosition = AppModel.CURRENT_SONG_SOUNDCHANNEL.position;
				AppModel.CURRENT_SONG_SOUNDCHANNEL.stop();
			}
		}
		
		public static function resume():void
		{
			if( AppModel.CURRENT_SONG_SOUNDCHANNEL )
			{
				trace('[CurrentSongManager]', 'resuming paused song');
				paused = false;
				AppModel.CURRENT_SONG_SOUNDCHANNEL = AppModel.CURRENT_SONG.play( currentPosition );
			}
		}
		
		public static function playAlarm():void
		{
			if( !alarm )
			{
				alarm = AppModel.assetManager.getSound( "alarm" );
			}
			
			pause();
			trace('[CurrentSongManager]', 'playing alarm');
			alarmSoundChannel = alarm.play(0, 999);
		}
		
		public static function stopAlarm():void
		{
			if(alarmSoundChannel)
			{
				trace('[CurrentSongManager]', 'stopping alarm');
				alarmSoundChannel.stop();
				alarmSoundChannel = null;
			}
		}
	}
}