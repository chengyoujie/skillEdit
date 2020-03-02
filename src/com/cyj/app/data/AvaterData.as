package com.cyj.app.data
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.utils.ComUtill;

	public class AvaterData implements ICopyData
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
		
		public function copy():ICopyData
		{
			var cd:AvaterData = new AvaterData();
			cd.parse(JSON.parse(JSON.stringify(this)));
			cd.id = ComUtill.getOnlyId();
			return cd;
		}
		
		
		/**
		 * 
		 * 获取body的高度  如没有找到则返回0
		 * */
		public function getBodyHeight():Number
		{
			var config:Object = ToolsApp.projectData.config;
			if(!config)return 0;
			var bodyHeightCfgs:Object = config['body_height'] || {};
			var bodyCfg:Object = ComUtill.getResCfgByPath(path);
			if(!bodyCfg)return 0;
			var key:String = bodyCfg.resMenu + "_" + bodyCfg.res1;
			if(bodyHeightCfgs[key])
				return bodyHeightCfgs[key];
			return 0;
		}
		
	}
}