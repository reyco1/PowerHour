package com.reycogames.powerhour.data
{
	public class TrackVO
	{
		public var file:String;
		public var name:String;
		
		public function TrackVO()
		{
		}
		
		public static function create( tracks:Array ):Vector.<TrackVO>
		{
			var arr:Vector.<TrackVO> = new Vector.<TrackVO>();
			for (var a:int = 0; a < tracks.length; a++) 
			{
				var t:TrackVO = new TrackVO();
				t.file = tracks[a].file;
				t.name = tracks[a].name;
				arr.push( t );
			}
			return arr;			
		}
	}
}