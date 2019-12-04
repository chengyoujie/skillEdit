package com.cyj.app.view.app
{
	import avmplus.getQualifiedClassName;
	
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.EffectPlayDisplayType;
	import com.cyj.app.data.cost.EffectPlayEndType;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.data.cost.EffectPlayTiggerType;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.data.effect.EffectPlayMoveEndData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.app.effect.EffectPlayItem;
	import com.cyj.app.view.app.movectr.MoveControlCell;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.ui.app.RightViewUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.DragImage;
	import com.cyj.app.view.unit.Effect;
	import com.cyj.app.view.unit.EffectImage;
	import com.cyj.app.view.unit.Role;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	import morn.core.handlers.Handler;
	
	public class RightView extends RightViewUI
	{
		private var _effectPlayItemDatas:Array;
		private var _itemBindData:Vector.<BindData>;
		private var _moveBindData:Vector.<BindData>;
		
		private var _disPlayBindData:Vector.<BindData>;
		private var _dirIndex2Dir:Object = {};
		private var _dir2Dirindex:Object = {};
		
		
		public function RightView()
		{
			super();
		}
		
		public function initView():void
		{
			initEvent();
			_itemBindData = new Vector.<BindData>();
			_itemBindData.splice(0, 0,			
						new BindData(inputId, "id", "text", handleIdChange, handleIdChangeCheck),
						new BindData(comOwner, "effOwnerType", "selectedIndex", handleOwnerTypeChange),
						new BindData(comLayer, "layer", "selectedIndex", handleRefushScene),
						new BindData(comEndType, "endType", "selectedIndex", handleEndChange),
						new BindData(inputEndParam, "endParam", "text", null, handleCheckEndData),
						new BindData(comTigglerType, "tiggler", "selectedIndex", handleStarChange),
						new BindData(inputTigglerParam, "tigglerParam","text",  null , handleCheckStartData),
						new BindData(inputOffx, "offx", "text",handleRefushScene),
						new BindData(inputOffy, "offy", "text", handleRefushScene),
						new BindData(inputDelay, "delay")
					);
			_moveBindData = new Vector.<BindData>( );
			_moveBindData.splice(0, 0,		
				new BindData(comMoveTo, "type", "selectedIndex", handleMoveTypeChange, handleCheckMoveType),
				new BindData(inputSpeed, "speed"),
				new BindData(inputDistance, "distance", "text", handleDistanceChange),
				new BindData(comAutoRotaion, "rotation", "selectedIndex",handleRefushScene),
				new BindData(comMoveEase, "ease", "selectedIndex",handleRefushScene)
			);
			_disPlayBindData = new Vector.<BindData>();
			_disPlayBindData.splice(0, 0,		
//				new BindData(comDisType, "type", "selectedIndex",onDisplayTypeChange),
				new BindData(inputResName, "data", "text",handleRefushScene),
				new BindData(inputLoop, "loop"),
				new BindData(comDisDir, "dir", "selectedIndex",handleRefushScene, null, setDirFun, getDirFun)
			);
			listStep.dataSource = [];
		}
		
		public function initProject():void
		{
			
		}
		
		
		private function initEvent():void
		{
			btnAddStep.clickHandler = new Handler(handleAddStep);
			btnRemoveStep.clickHandler = new Handler(handleRemoveStep);
			listStep.selectHandler = new Handler(handleSelectStep);
			btnPlayItem.clickHandler = new Handler(handlePlayItem);
			btnPlayAll.clickHandler = new Handler(handlePlayAll);
			btnResetMoveDis.clickHandler = new Handler(handleResetMoveDis);
			btnResetOffset.clickHandler = new Handler(handleResetOffset);
			SimpleEvent.on(AppEvent.AVATER_MOVE, handleSceneAvaterMove);
			SimpleEvent.on(AppEvent.EFFECT_CHANGE, handleEffectChange);
			SimpleEvent.on(AppEvent.ITEM_ADD_RES, handleAddRes);
			SimpleEvent.on(AppEvent.EFFECT_OPER_SET_CHANGE, handleRefushOperChange);
			SimpleEvent.on(AppEvent.REFUSH_RIGHT, handleRefushRight);
			SimpleEvent.on(AppEvent.AVATER_TYPE_CHANGE, handleRefushScene);
			SimpleEvent.on(AppEvent.REFUSH_SCENE, handleRefushScene);
		}
		
		private function handleResetMoveDis():void
		{
			inputDistance.text = "0";
		}
		private function handleResetOffset():void
		{
			inputOffx.text = "0";
			inputOffy.text = "0";
		}
		
		private function setDirFun(value:*):*
		{
			if(_dirIndex2Dir[value])
				return _dirIndex2Dir[value];
			return Direction.TOP;
		}
		private function getDirFun(value:*):*
		{
			if(_dir2Dirindex[value])
				return _dir2Dirindex[value];
			return 0;
		}
		
		private function handleStarChange():void
		{
			var type:int = comTigglerType.selectedIndex;
			if(type == EffectPlayTiggerType.PlayComplete)
			{
				boxTigglerParam.visible = true;
//				if(!handleCheckStartData(inputTigglerParam.text))
//				{
					var id:String = "0";
					var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
					if(selectItem)
					{
						var idx:int = _effectPlayItemDatas.indexOf(selectItem);
						if(idx>0)
						{
								id = _effectPlayItemDatas[idx-1].id;
						}
					}
					inputTigglerParam.text = id;
//					TipMsg.show("当前没有找到结束条件对应的项，设置默认值为0");
//				}
			}else{
				boxTigglerParam.visible = false;
			}
		}
		
		private function handleCheckStartData(data:String):Boolean
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return true;
			var type:int = comTigglerType.selectedIndex;
			if(type == EffectPlayTiggerType.PlayComplete)
			{
				var list:Array = _effectPlayItemDatas;
				if(!list)return false;
				for(var i:int=0; i<list.length; i++)
				{
					if(int(data) == list[i].id)
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function handleCheckEndData(data:String):Boolean
		{
			return true;
		}
		
		private function handleEndChange():void
		{
			var type:int = comEndType.selectedIndex;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			if(type == EffectPlayEndType.EffectPlayComplete)
			{
				if(int(inputLoop.text)<=0)
				{
					TipMsg.show("设置为播放完成，播放次数不能小于0, 设置默认为1");
					selectItem.disInfo.loop = 1;
					toBind(_disPlayBindData, selectItem.disInfo);
				}
				boxEndParam.visible = false;
			}else if(type == EffectPlayEndType.MoveEnd)
			{
				if(comMoveTo.selectedIndex == EffectPlayOwnerType.None)
				{
					TipMsg.show("当前设置移动完成，需要设置移动信息， 设置默认移动");
					selectItem.move.type = selectItem.effOwnerType==EffectPlayOwnerType.Sender?EffectPlayOwnerType.Target:EffectPlayOwnerType.Sender;
					selectItem.move.rotation = true;
					selectItem.move.speed = 500;
					toBind(_moveBindData, selectItem.move);
					handleMoveTypeChange();
				}
				boxEndParam.visible = false;
			}else if(type == EffectPlayEndType.Time)
			{
				boxEndParam.visible = true;
				if(int(inputEndParam.text)<=0)
				{
					TipMsg.show("设置结束时间不能为空， 设置默认1秒");
					selectItem.endParam = 1000;
					toBind(_itemBindData, selectItem);
				}
			}
		}
		
		private function handleRefushScene(e:Event=null):void
		{
			if(!_effectPlayItemDatas)return;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			ToolsApp.effectPlayer.playItem(selectItem, true);
		}
		
		private function onDisplayTypeChange():void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			if(selectItem.disInfo.type == EffectPlayDisplayType.Image)
			{
				boxLoop.visible = boxDir.visible = false;
			}else{
				boxLoop.visible = boxDir.visible = true;
			}
		}
		
		private function handleMoveTypeChange():void
		{
			boxMove.visible = comMoveTo.selectedIndex != EffectPlayOwnerType.None;  
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			if(selectItem.move.type != EffectPlayOwnerType.None && selectItem.disInfo.type == EffectPlayDisplayType.MovieClip && selectItem.disInfo.loop>0)
			{
				TipMsg.show("提示：设置移动后最好设置Loop为0");
			}
			toBind(_moveBindData, selectItem.move);
			SimpleEvent.send(AppEvent.MOVE_CHANGE,"type");
		}
		
		private function handleCheckMoveType(index:int):Boolean
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return false;
			if(selectItem.effOwnerType == EffectPlayOwnerType.None)
			{
				TipMsg.show("当前没有设定拥有者");
				return false;
			}else if(selectItem.effOwnerType == index)
			{
				TipMsg.show("当前移动类型与拥有者类型相同");
				return false;
			}
			if(index != EffectPlayOwnerType.None)
			{
//				if(!selectItem.move.speed)
//				{
//					selectItem.move.speed = 500;
//					selectItem.move.rotation = true;
//				}
				if(selectItem.disInfo.loop)
				{
					selectItem.disInfo.loop = 0;
					TipMsg.show("特效的loop设置为零");
				}
			}
			return true;
		}
		
		private function handleOwnerTypeChange():void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(selectItem)
			{
				if(selectItem.effOwnerType == EffectPlayOwnerType.None)
				{
					selectItem.move.type =EffectPlayOwnerType.None; 
					TipMsg.show("当前类型为None，移动类型设置为None");
					toBind(_moveBindData, selectItem.move);
					handleMoveTypeChange();
				}else if(selectItem.effOwnerType == selectItem.move.type)
				{
					selectItem.move.type =EffectPlayOwnerType.None; 
					toBind(_moveBindData, selectItem.move);
					handleMoveTypeChange();
					TipMsg.show("当前类型与移动目标类型相同，移动类型设置为None");
				}
			}
			handleRefushScene();
			
		}
		
		private function handlePlayItem():void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			ToolsApp.effectPlayer.playItem(selectItem, true);
		}
		private function handlePlayAll():void
		{
			ToolsApp.effectPlayer.play();
		}
		
		private function handleIdChange():void
		{
			var step:EffectStepItem = listStep.selection as EffectStepItem;
			if(step)
			{
				step.refush();
			}
		}
		private function handleIdChangeCheck(newId:String):Boolean
		{
			for(var i:int=0; i<_effectPlayItemDatas.length; i++)
			{
				if(_effectPlayItemDatas[i].id == int(newId))
				{
					TipMsg.show("新设置的id"+newId+"重复");
					return false;
				}
			}
			return true;
		}
		private var _tempZeroPoint:Point = new Point();
		/**场景中的角色移动了**/
		private function handleSceneAvaterMove(e:SimpleEvent):void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData; 
			if(!selectItem)return;
			var display:DisplayObject = e.data as DisplayObject;
			var item:EffectPlayItem
			var pos1:Point;
			var pos2:Point;
			var target:Role;
			if(display is Role)
			{
				var role:Role = display as Role;
				pos1 = role.localToGlobal(_tempZeroPoint);
				if(role.avaterType == EffectPlayOwnerType.None || role.avaterType != selectItem.effOwnerType)return;//旁观者不管 类型不关的不管
				else if(role.avaterType == EffectPlayOwnerType.Sender)
				{	
					if(selectItem.effOwnerType ==EffectPlayOwnerType.Sender)
					{	
						item = ToolsApp.effectPlayer.getEffectPlayItem(selectItem.id);
						if(!item || !item.display)return;
						pos2 = item.display.localToGlobal(_tempZeroPoint); 
						selectItem.offx = pos2.x - pos1.x;
						selectItem.offy = pos2.y - pos1.y;
						toBind(_itemBindData, selectItem);
					}
				}else if(role.avaterType == EffectPlayOwnerType.Target)
				{
					item = ToolsApp.effectPlayer.getEffectPlayItem(selectItem.id, role);
					if(!item || !item.display)return;
					pos2 = item.display.localToGlobal(_tempZeroPoint);	
					selectItem.offx = pos2.x - pos1.x;
					selectItem.offy = pos2.y - pos1.y;
					toBind(_itemBindData, selectItem);
				}
			}else if(display is Effect || display is EffectImage){
				var eff:DisplayObject = display as DisplayObject;
				item = ToolsApp.effectPlayer.getEffectPlayByDisplay(eff);
				if(!item)return;
				if(selectItem.effOwnerType == EffectPlayOwnerType.Sender)
					target = item.owner;
				else if(selectItem.effOwnerType == EffectPlayOwnerType.Target)
					target = item.target;
				if(!target)return;
				pos2 = eff.localToGlobal(_tempZeroPoint);
				pos1 = target.localToGlobal(_tempZeroPoint);
				selectItem.offx = pos2.x - pos1.x;
				selectItem.offy = pos2.y - pos1.y;
				toBind(_itemBindData, selectItem);
				ToolsApp.effectPlayer.refushPos();
			}else if(display is MoveControlCell){
				var ctr:MoveControlCell = display as MoveControlCell;
//				var targetDis:int = ComUtill.getDistance(ctr.control.fromCell.target, ctr.control.toCell.target);;
//				var cellDis:int = ComUtill.getDistance(ctr.control.fromCell, ctr.control.toCell);
				inputDistance.text = ctr.control.distance+""//(targetDis>distance?-1:1)*(distance)+"";
			}
		}
		
		private function handleDistanceChange():void
		{
			var items:Vector.<EffectPlayItem>;
			items  = ToolsApp.effectPlayer.items;
			if(items)
			{
				for(var i:int=0; i<items.length; i++)
				{
					items[i].doMove();
				}	
			}
			SimpleEvent.send(AppEvent.MOVE_CHANGE,"distance");
		}
		
		private function handleEffectChange(e:SimpleEvent):void
		{
			var data:Object = e.data;
			if(!data)return;
			_effectPlayItemDatas = data.data;
			listStep.dataSource = _effectPlayItemDatas;
			if(_effectPlayItemDatas.length>0)
				listStep.selectedIndex = 0;
		}
		
		private function toBind(binds:Vector.<BindData>, data:Object):void
		{
			for(var i:int=0; i<binds.length; i++)
			{
				binds[i].bind(data);
			}
		}
		
		private function handleRefushRight(e:SimpleEvent):void
		{
			if(listStep.selectedIndex<0)
				listStep.selectedIndex = 0;
			if(_effectPlayItemDatas)
				listStep.dataSource = _effectPlayItemDatas;
			handleSelectStep(listStep.selectedIndex);
		}
		
		private function handleSelectStep(index:int):void
		{
			if(!_effectPlayItemDatas)return;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			ToolsApp.projectData.curEffectPlayItemData = selectItem;
			if(!selectItem)return;
			toBind(_itemBindData, selectItem);
			toBind(_moveBindData, selectItem.move);
			toBind(_disPlayBindData, selectItem.disInfo);
			ToolsApp.effectPlayer.playItem(selectItem, true);
			onDisplayTypeChange();
			handleStarChange();
			handleEndChange();
			var items:Vector.<EffectPlayItem> = ToolsApp.effectPlayer.items;
			if(items.length>0 && items[0].display is Avatar)
				handleSetCanUseDir(Avatar(items[0].display));
			boxMove.visible = comMoveTo.selectedIndex != EffectPlayOwnerType.None;  
			SimpleEvent.send(AppEvent.EFFECT_STEP_CHANGE, selectItem);
		} 
		
		private function handleRefushOperChange(e:SimpleEvent):void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			var i:int = 0;
			if(e.data == "layer")
			{
				ToolsApp.effectPlayer.refushContain();
				toBind(_itemBindData, selectItem);
			}else if(e.data == "owner")
			{
				ToolsApp.effectPlayer.playItem(selectItem, true);
				toBind(_itemBindData, selectItem);
			}else if(e.data == "loop")
			{
				toBind(_disPlayBindData, selectItem.disInfo);
			}else if(e.data == "dir")
			{
				if(selectItem.disInfo.dir == Direction.TO_TARGET_DIR)//需要重置下对象
				{
					ToolsApp.effectPlayer.playItem(selectItem);
				}else{
					ToolsApp.effectPlayer.refushDisplay();	
				}
				
				toBind(_disPlayBindData, selectItem.disInfo);
			}
//			else if(e.data == "move")
//			{
//				ToolsApp.effectPlayer.doMove();
//			}
		}
		
		private function handleAddRes(e:SimpleEvent):void
		{
			var avt:* = e.data.display;
			var drop:Role = e.data.dropTarget;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			if(avt is DragImage)//如果是图片， 设置图片的默认设置
			{
				if(drop)
				{
					selectItem.effOwnerType = drop.avaterType;
				}
				selectItem.endType = EffectPlayEndType.Time;
				selectItem.endParam = 2000;
				selectItem.disInfo.type = EffectPlayDisplayType.Image;
				selectItem.disInfo.data = ToolsApp.projectData.getImageNameByPath(DragImage(avt).path);
			}else if(avt is Avatar){//如果是特效  则设置特效的默认设置
				if(drop)
				{
					selectItem.effOwnerType = drop.avaterType;
				}
				selectItem.endType = EffectPlayEndType.EffectPlayComplete;
				selectItem.disInfo.loop = 1;
				selectItem.disInfo.type = EffectPlayDisplayType.MovieClip;
				selectItem.disInfo.data =  ComUtill.getAvtResIdByPath(Avatar(avt).path);
				handleSetCanUseDir(avt);
			}else{
				TipMsg.show("拖入了不能识别的资源"+getQualifiedClassName(avt));
			}
			toBind(_itemBindData, selectItem);
			toBind(_disPlayBindData, selectItem.disInfo);
			handleOwnerTypeChange();
			onDisplayTypeChange();
			handleEndChange();
			ToolsApp.effectPlayer.playItem(selectItem, true);
		}
		
		private function handleSetCanUseDir(avt:Avatar):void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			var dir:int = selectItem.disInfo.dir;
			var canUseDirs:Array = Avatar(avt).getActHaveDirs(Action.ACTION_TYPE_ACT);
			var dirStrs:Array = [];
			_dir2Dirindex = {};
			_dirIndex2Dir = {};
			for(var i:int=0; i<canUseDirs.length; i++)
			{
				dirStrs.push(Direction.getDirName(canUseDirs[i]));
				_dir2Dirindex[canUseDirs[i]] = i;
				_dirIndex2Dir[i] = canUseDirs[i];
			}
			comDisDir.labels = dirStrs.join(",");
			
			if((dir == Direction.OWNER_DIR || dir == Direction.TO_TARGET_DIR) )
			{
				if(canUseDirs.length==1)//只有一个方向的
				{
					dir = canUseDirs[0];
					TipMsg.show("因为当前特效只有一个方向， 所以当前播放方向"+Direction.getDirName(selectItem.disInfo.dir)+"自动修改为"+Direction.getDirName(dir));
				}
			}else if(canUseDirs.indexOf(dir) == -1)
			{
				dir = canUseDirs[0];
				TipMsg.show("因为当前特效没有方向"+Direction.getDirName(selectItem.disInfo.dir)+" 自动修改为"+Direction.getDirName(dir));	
			}
			selectItem.disInfo.dir = dir;
			toBind(_disPlayBindData, selectItem.disInfo);
		}
		
		private function handleAddStep():void
		{
			if(!_effectPlayItemDatas)return;
			var item:EffectPlayItemData = new EffectPlayItemData();
			item.id = getNewId();
			_effectPlayItemDatas.push(item);
			listStep.dataSource = _effectPlayItemDatas;
			listStep.selectedIndex = _effectPlayItemDatas.length -1;
		}
		private function handleRemoveStep():void
		{
			if(!_effectPlayItemDatas)return;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(selectItem)
			{
				var index:int = _effectPlayItemDatas.indexOf(selectItem);
				if(index!=-1)
					_effectPlayItemDatas.splice(index, 1);
			}
			listStep.dataSource = _effectPlayItemDatas;
		}
		
		private function getNewId():int
		{
			if(!_effectPlayItemDatas)return 0;
			var idx:int = 0;
			for(var i:int=0; i<_effectPlayItemDatas.length; i++)
			{
				if(_effectPlayItemDatas[i].id > idx)
					idx = _effectPlayItemDatas[i].id;
			}
			return idx+1;
		}
		
	}
}