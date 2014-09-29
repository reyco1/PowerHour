package com.reycogames.powerhour.screens
{
	import com.reycogames.powerhour.screens.core.AbstractScreen;
	
	import feathers.controls.ScrollText;
	import feathers.layout.AnchorLayoutData;
	
	public class HowToPlayScreen extends AbstractScreen
	{
		private var scrollText:ScrollText;
		
		public function HowToPlayScreen()
		{
			super("How To Play");
		}
		
		override protected function initializeHandler():void
		{
			super.initializeHandler();
			
			var text:String = "It's quite simple actually! Choose length of game, Choose Playlist and start drinking! The heart of the POWERHOUR app is to give those fellow drinking buddies a good reason to drink before going out to the clubs or whatever else you got planned. Its fun, simple and gets you drunk in a good fast way!";
			text += "<br/><br/>";
			text += "1. Choose how long you want to play, the normal game is usually 1hour. But if your a chicken you can play for less, or if your hardcore, you can play till you drop!";
			text += "<br/><br/>";
			text += "2. We have built an easy Native playlist integration which allows you to have full control over your music and the ability to skip track in-game! Useful to not have to worry about organization before the party!!";
			text += "<br/><br/>";
			text += "3. Main logic of the game is take a shot of beer every minute for 1 hour. There is a bell to alert you its time to drink, and it automatically goes to next round.";
			
			scrollText = new ScrollText();
			scrollText.isHTML = true;
			scrollText.text = text;
			scrollText.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this.addChild(scrollText);
		}
	}
}