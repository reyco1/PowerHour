package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ImageButton extends Button
	{
		public var onTrigger:Function;
		
		private var upImageTexture:Texture;
		private var downImageTexture:Texture;
		private var numWidth:Number;
		
		public function ImageButton( skin:String, numWidth:Number = -1 )
		{
			super();
			
			upImageTexture 		= AppModel.getTexture( skin );
			downImageTexture 	= AppModel.getTexture( skin );
			
			this.numWidth = numWidth;
			
			stateToSkinFunction = newSkinFunction;
			
			addEventListener( Event.TRIGGERED, button_triggeredHandler );
		}
		
		private function newSkinFunction( target:Button, state:Object, oldSkin:DisplayObject = null ):DisplayObject
		{
			var skin:ImageLoader = oldSkin as ImageLoader;
			if( !skin )
			{
				skin = new ImageLoader();
				skin.maintainAspectRatio = true;
				if(numWidth > -1)
				{
					skin.width = numWidth;
					skin.validate();
				}
			}
			
			switch( state )
			{
				case Button.STATE_DISABLED:
				case Button.STATE_DOWN:
				{
					skin.source = downImageTexture;
					skin.alpha = 0.65;
					break;
				}
				
				case Button.STATE_HOVER:
				default:
				{
					skin.source = upImageTexture;	
					skin.alpha = 1;
				}
			}
			return skin;
		}
		
		private function button_triggeredHandler( event:Event ):void
		{
			if(onTrigger != null)
				onTrigger.call(null);
		}
	}
}