package com.reycogames.powerhour.screens.core
{
	import feathers.controls.ScreenNavigator;	
	import starling.display.DisplayObject;
	
	public class ScreenNavigatorWithHistory extends ScreenNavigator
	{
		private var _history:Vector.<String>;
		
		public function ScreenNavigatorWithHistory()
		{
			super();
			_history = new Vector.<String>;
		}
		
		override public function showScreen(id:String):DisplayObject
		{
			_history.push(id);
			return super.showScreen(id);
		}
		
		public function goBack():void
		{
			if (_history.length > 1) {
				_history.pop();
				super.showScreen(_history[_history.length - 1])
			}
		}
		
		public function clearHistory():void
		{
			_history = new Vector.<String>;
		}
		
	}
	
}