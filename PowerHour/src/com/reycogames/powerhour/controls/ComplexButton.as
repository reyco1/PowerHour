package com.reycogames.powerhour.controls
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ComplexButton extends Sprite
	{
		public var onTrigger:Function;
		
		public function ComplexButton()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, initializeHandler );
		}
		
		protected function initializeHandler( event:Event ):void
		{
			touchable = true;
			addEventListener( TouchEvent.TOUCH, handlClicked );
		}
		
		private function handlClicked( event:TouchEvent ):void
		{
			var touch:Touch = event.getTouch(this);
			
			if( touch && touch.phase == TouchPhase.BEGAN )
			{
				alpha = 0.5;
				if(onTrigger != null)
					onTrigger.call(null);
			}
			
			if( touch && touch.phase == TouchPhase.ENDED )
			{
				alpha = 1;
			}
		}
	}
}