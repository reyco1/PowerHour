package com.reycogames.powerhour.manager
{
	public class PauseManager
	{
		public static var isPaused:Boolean = false;
		private static var pausedBecauseOfLostContext:Boolean = false;
		
		public static function toggle():void
		{
			if(isPaused)
			{
				resume();
			}
			else
			{
				pause();
			}
		}
		
		public static function pause( lostContext:Boolean = false ):void
		{
			if(!isPaused)
			{
				isPaused = true;
				GameTimer.pause();
				CurrentSongManager.pause();
				pausedBecauseOfLostContext = lostContext;
			}
		}
		
		public static function resume( returnFromLostContext:Boolean = false ):void
		{
			if(isPaused)
			{
				if((pausedBecauseOfLostContext && returnFromLostContext) || (!pausedBecauseOfLostContext && !returnFromLostContext))
				{
					isPaused = false;
					GameTimer.resume();
					CurrentSongManager.resume();
				}
			}
		}
	}
}