package com.cyj.app.view.app.effect
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.data.cost.EffectPlayTiggerType;
	import com.cyj.app.data.cost.RotationType;
	import com.cyj.app.data.effect.EffectPlayData;
	import com.cyj.app.data.effect.EffectPlayDisplayInfo;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.view.app.AppEvent;
	import com.cyj.app.view.app.CenterView;
	import com.cyj.app.view.app.EffectItem;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.Role;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	public class EffectPlayer
	{
		private var _view:CenterView;
		private var _items:Vector.<EffectPlayItem> = new Vector.<EffectPlayItem>();
		private var _itemsDic:Object = {};
		private var _playEndItemDic:Object={};
		private var _isRuning:Boolean = false;
		private var _mouseEnable:Boolean = true;
		
		public function EffectPlayer(view:CenterView)
		{
			_view = view;
		}
		
		public function play():void
		{
			clearAll();
			_isRuning = true;
			_playEndItemDic = {};
			initAllItems();
			checkCanPlay();
		}
		
		private function initAllItems():void
		{
			var items:Array = ToolsApp.projectData.curEffectPlayList;
			if(!items)return;
			var targets:Vector.<Role> = _view.roleLayer.targets;
			var defaultTagret:Role = targets&&targets.length>0?targets[0]:null;
			for(var i:int=0; i<items.length; i++)
			{
				var item:EffectPlayItemData = items[i];
				if(isOnTarget(item) )
				{
					for(var j:int=0; j<targets.length; j++)
					{
						getItem(item, _view.roleLayer.owner, targets[j], true);
					}
				}else if(defaultTagret && item.effOwnerType == EffectPlayOwnerType.OneTarget){
					getItem(item,  defaultTagret,_view.roleLayer.owner, true);
				}else{
					getItem(item, _view.roleLayer.owner, defaultTagret, true);
				}
			}
		}
		
		private function checkCanPlay():void
		{
			if(!_items)return;
			var j:int = 0;
			var targets:Vector.<Role> = _view.roleLayer.targets;
			for(var i:int=0; i<_items.length; i++)
			{
				var item:EffectPlayItem = items[i];
				if(item.isPlaying)continue;
				var effItem:EffectPlayItem;
				if(item.data.tiggler == EffectPlayTiggerType.Start)
				{
					item.play(itemPlayEnd);
				}else if(item.data.tiggler == EffectPlayTiggerType.PlayComplete)
				{
					var state:* = null;
					if(item.target)
					{
						state = _playEndItemDic[item.data.tigglerParam+"_"+item.target.onlyId];
						if(!(state is Boolean))
							state = _playEndItemDic[item.data.tigglerParam];
					}else
						state = _playEndItemDic[item.data.tigglerParam];
					if(state == true)
					{
						item.play(itemPlayEnd);
					}
				}
			}
		}
		
		
		
		public function playItem(data:EffectPlayItemData, isClearn:Boolean = true, isPlayAll:Boolean=false):void
		{
			if(isClearn)
				clearAll();
			var isTargetEffect:Boolean = isOnTarget(data);
			var targets:Vector.<Role> = _view.roleLayer.targets;
			var defaultTagret:Role = targets&&targets.length>0?targets[0]:null;
			var item:EffectPlayItem;
			if(isTargetEffect)
			{
				if(targets.length == 0)
				{
					TipMsg.show("没有找到受击者，请添加受击者");
				}
				for(var i:int=0; i<targets.length; i++)
				{
					getItem(data, _view.roleLayer.owner, targets[i], isPlayAll, i);
				}
			}else if(defaultTagret && data.move.type == EffectPlayOwnerType.OneTarget)
			{
				getItem(data,_view.roleLayer.owner , defaultTagret,  isPlayAll);
			}else if(defaultTagret && data.effOwnerType == EffectPlayOwnerType.OneTarget)
			{
				getItem(data, defaultTagret, _view.roleLayer.owner , isPlayAll);
			}else if(defaultTagret && data.rotationType == RotationType.ONE_TARGET)
			{
				getItem(data, _view.roleLayer.owner ,defaultTagret,  isPlayAll);
			}
			else{
				getItem(data, _view.roleLayer.owner, null, isPlayAll);
			}
		} 
		
		private function getItem(data:EffectPlayItemData, owner:Role, target:Role, isPlayAll:Boolean=false, index:int=0):EffectPlayItem
		{
			var item:EffectPlayItem = new EffectPlayItem();
			item.setData(data, owner, target, index);
			if(isPlayAll)
			{
				_playEndItemDic[data.id] = false;
				if(target)
					_playEndItemDic[data.id+"_"+target.onlyId] = false;
			}else{
				item.play(null);
			}
			if(target)
				_itemsDic[data.id+"_"+target.onlyId] = item;
			else
				_itemsDic[data.id] = item;
			item.mouseEnable = _mouseEnable;
			_items.push(item);
			return item;
		}
		
		private function itemPlayEnd(item:EffectPlayItem):void
		{
			var index:int = _items.indexOf(item);
			if(item.target)
			{
				_playEndItemDic[item.data.id+"_"+item.target.onlyId] = true;
				_playEndItemDic[item.data.id] = true;
			}else
				_playEndItemDic[item.data.id] = true;
			if(index != -1)
			{
				_items.splice(index, 1);
			}
			item.dispose();
			item = null;
			if(_items.length == 0)
			{
				TipMsg.show("播放完毕");
				App.timer.doOnce(1000, refushScene);
			}else{
				checkCanPlay();
			}
		}
		
		private function refushScene():void
		{
			App.timer.clearTimer(refushScene);
			SimpleEvent.send(AppEvent.REFUSH_SCENE);
		}
		
		public function clearAll():void
		{
			while(_items.length>0)
			{
				var item:EffectPlayItem = _items.pop();
				item.dispose();
			}
			_itemsDic = {};
			_playEndItemDic = {};
		}
		
		public function getEffectPlayItem(id:int, target:Avatar=null):EffectPlayItem
		{
			if(target)
				return _itemsDic[id+"_"+target.onlyId];
			else
				return _itemsDic[id];
		}
		
		public function getEffectPlayByDisplay(display:DisplayObject):EffectPlayItem
		{
			for(var i:int=0; i<_items.length; i++)
			{
				if(_items[i].display == display)
					return _items[i];
			}
			return null;
		}
		
		public function get items():Vector.<EffectPlayItem>
		{
			return _items;
		}
		
		
		public function set mouseEnable(value:Boolean):void
		{
			_mouseEnable = value;
			if(_items)
			{
				for(var i:int=0; i<_items.length; i++)
				{
					_items[i].mouseEnable = _mouseEnable;
				}
			}
		}
		public function get mouseEnable():Boolean
		{
			return _mouseEnable;
		}
		
		public function refushContain():void
		{
			if(!_items)return;
			for(var i:int=0; i<_items.length; i++)
			{
				_items[i].refushContain();
			}	
		}
		public function refushDisplay():void
		{
			if(!_items)return;
			for(var i:int=0; i<_items.length; i++)
			{
				_items[i].refushDisplay();
			}	
		}
		public function refushRotation():void
		{
			if(!_items)return;
			for(var i:int=0; i<_items.length; i++)
			{
				_items[i].refushRotation();
			}	
		}
		public function doMove():void
		{
			if(!_items)return;
			for(var i:int=0; i<_items.length; i++)
			{
				_items[i].doMove();
			}	
		}
		public function refushPos():void
		{
			if(!_items)return;
			for(var i:int=0; i<_items.length; i++)
			{
				_items[i].refushPos();
			}	
		}
		
		public function refushTween():void
		{
			if(!_items)return;
			for(var i:int=0; i<_items.length; i++)
			{
				_items[i].refushTween();
			}	
		}
		
		/**是否作用于目标 由于目标可能是多个所以会创建多个EffectItem */
		private function isOnTarget(info:EffectPlayItemData):Boolean
		{
			if(info.effOwnerType == EffectPlayOwnerType.Target)
				return true;
			if(info.move && info.move.type == EffectPlayOwnerType.Target)
				return true;
			if(info.disInfo.dir == Direction.TO_TARGET_DIR)
				return true;
			if(info.rotationType == RotationType.TARGET && info.move.type != EffectPlayOwnerType.OneTarget)
				return true;
			return false;
		}
	}
	
//	class EffectPlayState{
//		public static const None:int = 0;
//		public static const Runing = 1;
//		public static  const END = 2;
//	}
	
}