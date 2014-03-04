package com.reycogames.powerhour.controls
{
	import flash.text.TextFormat;
	
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	
	public class CustomLabel extends Label
	{
		public function CustomLabel(font:String = "Arial Black", color:uint = 0xF48032, size:Number = 30)
		{
			super();
			
			textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( font, size, color );
				textRenderer.embedFonts = true;
				return textRenderer;
			}
		}
		
		override public function set text(value:String):void
		{
			super.text = value;
			validate();
		}
	}
}

