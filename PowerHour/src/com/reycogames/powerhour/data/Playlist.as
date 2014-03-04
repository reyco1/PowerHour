package com.reycogames.powerhour.data
{
	public class Playlist
	{
		public var title:String;
		public var tracks:Vector.<TrackVO>;
		
		public function Playlist()
		{
		}
		
		public static function create( object:Object ):Playlist
		{
			var pl:Playlist = new Playlist();
			pl.title = object.title;
			pl.tracks = TrackVO.create( object.tracks );
			return pl;
		}
	}
}