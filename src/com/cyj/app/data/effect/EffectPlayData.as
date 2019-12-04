package com.cyj.app.data.effect
{
	import flash.utils.Dictionary;

	public class EffectPlayData
	{
		private var _dic:Object = {};
		public function EffectPlayData()
		{
		}
		
		public function parser(value:Object):void
		{
			for(var key:String in value)
			{
				var arr:Array = value[key];
				var items:Array = [];
				for(var i:int=0; i<arr.length; i++)
				{
					var item:EffectPlayItemData = new EffectPlayItemData();
					item.parser(arr[i]);
					items.push(item);
				}
				_dic[key] = items;
			}
		}
		
		public function get list():Array
		{
			var list:Array = [];
			for(var key:String in _dic)
			{
				list.push({id:key, data:_dic[key]});
			}
			return list;
		}
		
		public function addItem(id:int=-1, items:Array=null):void
		{
			var curId:int = id;
			if(curId <0)
			{
				for(var key:String in _dic)
				{
					if(curId<=int(key))
					{
						curId = int(key)+1;
					}
				}
			}
			if(!items)items = [new EffectPlayItemData()];
			_dic[curId] = items;
		}
		
		public function get data():Object
		{
			return _dic;
		}
		
		public function removeItem(id:int):void
		{
			if(_dic[id])
			{
				delete _dic[id];
			}
		}
		
		
	}
}