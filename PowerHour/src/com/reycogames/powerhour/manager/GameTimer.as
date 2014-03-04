package com.reycogames.powerhour.manager
{
	import com.reycogames.powerhour.model.AppModel;
	import com.reycogames.powerhour.model.AppScreens;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class GameTimer
	{
		public static var update:Function;		
		public static var gameTimer:Timer;
		public static var seconds:int = 60;
		
		public static function init( autoStart:Boolean = true):void
		{
			seconds = 60;
			
			if( !gameTimer )
			{
				gameTimer = new Timer( 1000, 60 );
				gameTimer.addEventListener(TimerEvent.TIMER, handleTimerTick );
				gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete );
				
				if(autoStart)
					start();
			}
		}
		
		public static function start():void
		{
			if(gameTimer)
				gameTimer.start();
		}
		
		public static function pause():void
		{
			if(gameTimer)
				gameTimer.stop();
		}
		
		public static function resume():void
		{
			if(gameTimer)
				gameTimer.start();
		}
		
		private static function handleTimerTick(event:TimerEvent):void
		{
			seconds--;
			if(update != null)
				update.call();
		}
		
		private static function handleTimerComplete(event:TimerEvent):void
		{
			AppModel.MINUTES--;
			AppModel.navigator.showScreen( AppScreens.ALARM_SCREEN );
		}
		
		public static function clear():void
		{
			if(gameTimer)
			{
				gameTimer.stop();
				gameTimer.removeEventListener(TimerEvent.TIMER, handleTimerTick );
				gameTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleTimerComplete );
				gameTimer = null;
			}
		}
	}
}