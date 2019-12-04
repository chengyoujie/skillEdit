package com.cyj.app.view.unit
{
	import com.cyj.app.data.AvaterData;

	public class Effect extends Avatar
	{
		public function Effect(data:AvaterData)//$path:String, isDirRes:Boolean=false, dir:int=-1, act:String=null
		{
			super(data);
			this.mouseChildren = false;
			drawBg(0xffff00);
		}
	}
}