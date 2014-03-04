package com.reycogames.powerhour.controls
{
	import com.reycogames.powerhour.model.AppModel;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class DrawerThumb extends Button
	{
		public var onTrigger:Function;
		
		private var upImageTexture:Texture;
		private var downImageTexture:Texture;
		private var numWidth:Number;
		private var numHeight:Number;
		private var customSkin:ImageLoader;
		
		public function DrawerThumb( numHeight:Number = -1 )
		{
			super();
			
			upImageTexture = AppModel.getTexture( "drawer_thumb.fw" );			
			this.numHeight = numHeight;			
			stateToSkinFunction = newSkinFunction;			
			addEventListener( Event.TRIGGERED, button_triggeredHandler );
		}
		
		private function newSkinFunction( target:Button, state:Object, oldSkin:DisplayObject = null ):DisplayObject
		{
			customSkin = oldSkin as ImageLoader;
			if( !customSkin )
			{
				customSkin = new ImageLoader();
				customSkin.maintainAspectRatio = true;
				if(numWidth > -1)
				{
					customSkin.height = numHeight;
					customSkin.validate();
				}
			}
			customSkin.source = upImageTexture;
			return customSkin;
		}
		
		private function button_triggeredHandler( event:Event ):void
		{
			if(onTrigger != null)
				onTrigger.call(null);
		}
		
		private function setheight( value:Number ):void
		{
			customSkin.height = value;
			customSkin.validate();
		}
	}
}

