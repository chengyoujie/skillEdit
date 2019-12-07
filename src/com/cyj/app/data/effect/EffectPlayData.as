package com.cyj.app.data.effect
{
	import com.cyj.app.data.EffectGroupItemData;
	import com.cyj.app.data.ICopyData;
	
	import flash.utils.Dictionary;

	public class EffectPlayData implements ICopyData
	{
		private var _items:Array = [];
		public function EffectPlayData()
		{
		}
		
		public function parser(value:Object):void
		{
			_items.length = 0;
			for(var key:String in value)
			{
				var gItem:* = value[key];
//				var arr:Array = gItem.data;
//				var items:Array = [];
//				for(var i:int=0; i<arr.length; i++)
//				{
//					var item:EffectPlayItemData = new EffectPlayItemData();
//					item.parser(arr[i]);
//					items.push(item);
//				}
				var groupItem:EffectGroupItemData = new EffectGroupItemData();
				groupItem.parser(gItem);
//				groupItem.id = gItem.id;
//				groupItem.name = gItem.name;
//				groupItem.data = items;
				_items.push(groupItem);
			}
		}
		
		public function get list():Array
		{
			return _items;
		}
		
		public function addItem(id:int=-1, items:Array=null):void
		{
			var curId:int = id;
			if(curId <0)
			{
				curId = 0;
				for(var i:int=0; i<_items.length; i++)
				{
					if(curId<=_items[i].id)
					{
						curId = _items[i].id+1;
					}
				}
			}
			var item:EffectGroupItemData = new EffectGroupItemData();
			item.id = curId;
			_items.push(item);
		}
		
		public function addItemData(data:EffectGroupItemData):void
		{
			var curId:int = 0;
			for(var i:int=0; i<_items.length; i++)
			{
				if(curId<=_items[i].id)
				{
					curId = _items[i].id+1;
				}
			}
			data.id = curId;
			_items.push(data);
		}
		
		public function get data():Object
		{
			var dic:Object = {};
			for(var i:int=0; i<_items.length; i++)
			{
				var item:EffectGroupItemData = _items[i];
				dic[item.id] = item;
			}
			return dic;
		}
		
		public function removeItem(id:int):void
		{
			for(var i:int=0; i<_items.length; i++)
			{
				if(id ==_items[i].id)
				{
					_items.splice(i, 1);
					return;
				}
			}
		}
		
		public function copy():ICopyData{
			var cd:EffectPlayData = new EffectPlayData();
			cd.parser(JSON.parse(JSON.stringify(data)));
			return cd;
		}
		
		
	}
}