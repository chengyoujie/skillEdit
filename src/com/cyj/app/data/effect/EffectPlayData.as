package com.cyj.app.data.effect
{
	import com.cyj.app.data.EffectGroupItemData;
	import com.cyj.app.data.ICopyData;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.data.cost.EffectPlayTiggerType;
	import com.cyj.app.view.common.Alert;
	
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
				gItem = JSON.parse(gItem.replace(/'/gi, '"'));
				var groupItem:EffectGroupItemData = new EffectGroupItemData();
				groupItem.parser(gItem);
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
				dic[item.id] = JSON.stringify(item).replace(/"/gi, "'");
			}
			return dic;
		}
		
		public function getErrStr():String
		{
			var err:String = "";
			for(var i:int=0; i<_items.length; i++)
			{
				var item:EffectGroupItemData = _items[i];
				var str:String = item.getErrStr();
				if(str)
				{
					err += item.id+":"+item.name+" -> "+str+"\n";
				}
			}
			return err;
		}
		
		/**
		 * 游戏中用到瘦身过的数据
		 * */
		public function get thinData():Object
		{
			var dic:Object = {};
			for(var i:int=0; i<_items.length; i++)
			{
				var item:EffectGroupItemData = _items[i];
				var jsonStr:String = JSON.stringify(item);
				var jsonData:Object = JSON.parse(jsonStr);
				var itemDatas:Array = jsonData.data;
				for(var k:int=0; k<itemDatas.length; k++)
				{
					thinDeleDefault(itemDatas[k]);
				}
				delete jsonData["name"];
				var json:String = JSON.stringify(jsonData);
				dic[item.id] = json.replace(/"/gi, "'");
			}
			return dic;
		}
		
		/***
		 * 游戏中使用的数据瘦身
		 * 去掉一些默认值，需要在游戏中对应的还原回去
		 * 
		 * */
		private function thinDeleDefault(data:Object):Object
		{
			delete data["name"];//要删除的名字
//			delete data["id"];//要删除的索引  有用到
			if(!data["bindOwner"]) delete data["bindOwner"];// useScreen:Boolean = false;
			if(!data["sound"]) delete data["sound"];// useScreen:Boolean = false;
			if(!data["useScreen"]) delete data["useScreen"];//bindOwner:Boolean = false;
			if(!data["tweenProps"] || !data["tweenProps"].length) delete data["tweenProps"];//缓动的参数
			if(!data["rotation"]) delete data["rotation"];//旋转角度 = 0
			if(!data["rotationType"]) delete data["rotationType"];//旋转类型 rotationType:int = 0;
			if(data["scalex"]==1) delete data["scalex"];// scalex:Number = 1
			if(data["scaley"]==1) delete data["scaley"];// scaley:Number = 1;
			if(data["offx"]=="0") delete data["offx"];// 偏移X offx:String = "0"
			if(data["offy"]=="0") delete data["offy"];//偏移Y offy:String = "0";
			if(data["offXType"]==0) delete data["offXType"];// 偏移X offx:String = "0"
			if(data["offYType"]==0) delete data["offYType"];//偏移Y offy:String = "0";
			
			if(!data["endParam"]) delete data["endParam"];//结束参数 endParam:* = 0
			if(!data["endParam2"]) delete data["endParam2"];//结束参数 endParam:* = 0
			if(!data["tigglerParam"]) delete data["tigglerParam"];//开始参数 tigglerParam:*=0
			if(!data["tiggler"]) delete data["tiggler"];//开始条件 tiggler =0
			if(!data["endType"]) delete data["endType"];//结束条件 endType:int=0
			
			
			if(!data["delay"]) delete data["delay"];//延迟执行时间 delay:int =0
			if(!data["delayType"]) delete data["delayType"];//延迟类型  delayType:int=0
			
			if(!data["layer"]) delete data["layer"];//特效所在的层级layer:int = EffectPlayLayer.MapTop; 
			if(!data["effOwnerType"]) delete data["effOwnerType"];//特效所有者 可以为空effOwnerType:int = EffectPlayOwnerType.Sender;
			
			if(data["disInfo"])//特效资源名字
			{
				var disInfo:Object = data["disInfo"];
				if(!disInfo["type"]) delete disInfo["type"];//显示对象的类型  type=0 mc
				if(disInfo["loop"]==1) delete disInfo["loop"];//循环次数默认为1， 只适用于Movie类型  loop:int = 1;
				if(!disInfo["dir"]) delete disInfo["dir"];//MC方向  如果不填则直接读取， 如果填了则使用有方向的资源  dir=0
			}
			if(data["move"])//移动参数 如果设置为move 则图层不能选择在角色身上（要不）
			{
				var move:Object = data["move"];
				if(move["type"] == EffectPlayOwnerType.None)//没有移动的直接删掉所有的信息
				{
					delete data["move"];
				}else{
					if(!move["rotationType"]) delete move["rotationType"];//旋转角度类型   rotationType = 0;
					if(!move["rotation"]) delete move["rotation"];//旋转角度   rotation:int = 0;
					if(!move["ease"]) delete move["ease"];//移动类型   ease:int = 0;if(data["offx"]==0) delete data["offx"];// 偏移X offx:String = "0"
					if(move["offx"]=="0") delete move["offx"];// 偏移X offx:String = "0"
					if(move["offy"]=="0") delete move["offy"];//偏移Y offy:String = "0";
					if(move["offXType"]==0) delete move["offXType"];// 偏移X offx:String = "0"
					if(move["offYType"]==0) delete move["offYType"];//偏移Y offy:String = "0";
					if(move["distanceType"]==0) delete move["distanceType"];//偏移类型  
					if(!move["distance"]) delete move["distance"];//移动类型   distance:int = 0;
					if(move["speed"]==500) delete move["speed"];//移动速度 与time二选一  优先time   distance:int = 0;
				}
			}
			return data;
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