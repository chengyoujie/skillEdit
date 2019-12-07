package com.cyj.app.data
{
	public class ImageData implements ICopyData
	{
		public var path:String;
		
		public function ImageData()
		{
		}
		
		public function copy():ICopyData{
			var data:ImageData = new ImageData();
			data.path = path;
			return data;
		}
	}
}