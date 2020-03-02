package com.cyj.app.data
{
	import com.cyj.app.data.effect.EffectPlayData;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.app.view.unit.SubImageInfo;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	public class ProjectData
	{
//		public var avaterRes:AvaterRes;
		public var config:Object;
		/**当前正在编辑的特效数据**/
		public var curEffectPlayList:Array;
		
		public var allEffectPlayData:EffectPlayData;
		/**当前正在编辑的特效列表中某一步的数据**/
		public var curEffectPlayItemData:EffectPlayItemData;
		
		/**当前焦点所在的对象的数据**/
		public var fouceData:ICopyData;
		/**复制内容**/
		public var copyData:ICopyData;
		/**上次保存的数据**/
		public var lastSaveEffectData:EffectPlayData;
		
		private var _imgName2PathDic:Object = {};
		private var _path2ImgNameDic:Object = {};
		
		public function setImagePath(path:String, name:String):void
		{
			name = name.replace(/\./gi, "_");
			_imgName2PathDic[name] = path;
			_path2ImgNameDic[path] = name;
		}
		
		public function getImagePathByName(name:String):String
		{
			return _imgName2PathDic[name];
		}
		public function getImageNameByPath(path:String):String
		{
			path = path.replace(/[\\\/]+/gi, "\\");
			return _path2ImgNameDic[path];
		}
		
		/**
		 * 	根据Menu获取对应的资源列表
		 * */
		public function getResCfgByMenu(...menu):Array
		{
			if(!config)return [];
			var resCfgs:Array = config["resBody"];
			var rect:Array = [];
			for(var i:int=0; i<resCfgs.length; i++)
			{
					if(menu.indexOf(resCfgs[i].resMenu)!=-1)
					{
						rect.push(resCfgs[i]);
					}
			}
			return rect;
		}
		
		/**
		 * 	根据Menu获取对应的资源列表
		 * */
		public function getResCfgDicByMenu(...menu):Object
		{
			if(!config)return {};
			var resCfgs:Array = config["resBody"];
			var rect:Object = {};
			for(var j:int=0; j<menu.length; j++)
			{
				rect[menu[j]] = [];
			}
			for(var i:int=0; i<resCfgs.length; i++)
			{
				if(menu.indexOf(resCfgs[i].resMenu)!=-1)
				{
					rect[resCfgs[i].resMenu].push(resCfgs[i]);
				}
			}
			return rect;
		}
		
		
		
		public function ProjectData()
		{
		}
		 
	}
}