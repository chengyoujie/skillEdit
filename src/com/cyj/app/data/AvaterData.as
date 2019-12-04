package com.cyj.app.data
{
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.utils.ComUtill;

	public class AvaterData
	{
//		{"id":_avtId, "x":avt.x, "y":avt.y, "path":avt.path, "isDirRes":avt.isDirRes, "dir":avt.dir, "act":avt.act }; 
		public var id:int;
		public var x:int;
		public var y:int;
		public var path:String;
		public var isDirRes:Boolean=false;
		public var dir:int=-1;
		public var act:String;
		public var type:int = EffectPlayOwnerType.Target;
		
		public function AvaterData($path:String=null, $isDirRes:Boolean = false)
		{
			this.path = $path;
			this.isDirRes = $isDirRes;
			this.id = ComUtill.getOnlyId();
		}
		
		public function parse(data:Object):void
		{
			for(var key:String in data)
			{
				if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
	}
}