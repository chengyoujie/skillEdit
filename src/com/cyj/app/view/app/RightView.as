package com.cyj.app.view.app
{
	import avmplus.getQualifiedClassName;
	
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.EffectGroupItemData;
	import com.cyj.app.data.ICopyData;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.EffectPlayDisplayType;
	import com.cyj.app.data.cost.EffectPlayEndType;
	import com.cyj.app.data.cost.EffectPlayOffsetType;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.data.cost.EffectPlayTiggerType;
	import com.cyj.app.data.cost.RotationType;
	import com.cyj.app.data.effect.EffectPlayData;
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
	import com.cyj.utils.Log;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
						new BindData(inputId, "id", "text", handleIdNameChange, handleIdChangeCheck),
						new BindData(inputName, "name", "text", handleIdNameChange),
						new BindData(comOwner, "effOwnerType", "selectedIndex", handleOwnerTypeChange),
						new BindData(comLayer, "layer", "selectedIndex", handleRefushScene),
						new BindData(comEndType, "endType", "selectedIndex", handleEndChange),
						new BindData(inputEndParam, "endParam", "text", null, handleCheckEndData),
						new BindData(comTigglerType, "tiggler", "selectedIndex", handleStarChange),
						new BindData(inputTigglerParam, "tigglerParam","text",  null , handleCheckStartData),
						new BindData(comOffsetXType, "offXType", "selectedIndex",handleRefushScene),
						new BindData(comOffsetYType, "offYType", "selectedIndex",handleRefushScene),
						new BindData(inputOffx, "offx", "text",handleRefushScene),
						new BindData(inputOffy, "offy", "text", handleRefushScene),
						new BindData(inputScalex, "scalex", "text",handleRefushScene),
						new BindData(inputScaley, "scaley", "text", handleRefushScene),
						new BindData(checkScreenPos, "useScreen", "selected", handleRefushScene),
						new BindData(checkBindOwner, "bindOwner", "selected", handleRefushScene),
						new BindData(inputDelay, "delay"),
						new BindData(comDealyTimeType, "delayType", "selectedIndex", handleRefushScene),
						new BindData(comRotation, "rotationType", "selectedIndex", handleRotationTypeChange),
						new BindData(inputRotation, "rotation", "text", handleRefushRotation)
					);
			_moveBindData = new Vector.<BindData>( );
			_moveBindData.splice(0, 0,		
				new BindData(comMoveTo, "type", "selectedIndex", handleMoveTypeChange, handleCheckMoveType),
				new BindData(inputSpeed, "speed", "text", handleRefushScene),
				new BindData(inputMoveRotation, "rotation", "text", handleRefushScene),
				new BindData(comMoveRotation, "rotationType", "selectedIndex", handleRefushScene),
				new BindData(inputDistance, "distance", "text", handleDistanceChange),
				new BindData(comMoveOffsetXType, "offXType", "selectedIndex",handleRefushScene),
				new BindData(comMoveOffsetYType, "offYType", "selectedIndex",handleRefushScene),
				new BindData(inputMoveOffX, "offx", "text", handleDistanceChange),
				new BindData(inputMoveOffY, "offy", "text", handleDistanceChange),
//				new BindData(comAutoRotaion, "rotation", "selectedIndex",handleRefushScene),
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
			listStep.addEventListener(MouseEvent.CLICK, handleSelectStep);
			btnPlayItem.clickHandler = new Handler(handlePlayItem);
			btnPlayAll.clickHandler = new Handler(handlePlayAll);
			btnResetMoveDis.clickHandler = new Handler(handleResetMoveDis);
			btnResetOffset.clickHandler = new Handler(handleResetOffset);
			btnTweenProp.clickHandler = new Handler(handleOpenTweenProp);
			btnTweenRefush.clickHandler = new Handler(handleTweenRefush);
			SimpleEvent.on(AppEvent.AVATER_MOVE, handleSceneAvaterMove);
			SimpleEvent.on(AppEvent.EFFECT_CHANGE, handleEffectChange);
			SimpleEvent.on(AppEvent.ITEM_ADD_RES, handleAddRes);
			SimpleEvent.on(AppEvent.EFFECT_OPER_SET_CHANGE, handleRefushOperChange);
			SimpleEvent.on(AppEvent.REFUSH_RIGHT, handleRefushRight);
			SimpleEvent.on(AppEvent.AVATER_TYPE_CHANGE, handleRefushScene);
			SimpleEvent.on(AppEvent.REFUSH_SCENE, handleRefushScene);
			SimpleEvent.on(AppEvent.SET_TWEEN_PROP, handleTweenChange);
		}
		
		private var _setTweenView:SetTweenView = new SetTweenView();
		private function handleOpenTweenProp():void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			_setTweenView.open(selectItem);
		}
		
		private function handleTweenChange(e:SimpleEvent):void
		{
			refushTweenDes();
			handleRefushScene();
		}
		
		private function handleTweenRefush():void
		{
			ToolsApp.effectPlayer.refushTween();
		}
		
		
		private function refushTweenDes():void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			var tweens:Array = selectItem.tweenProps;
			var des:String = "<font color='#00ff00'>";
			for(var i:int=0; i<tweens.length; i++)
			{
				for(var k:int=0; k<tweens[i].items.length; k++)
				{
					des += " "+SetTweenView.tweenData[tweens[i].items[k].prop].name+",";
				}	
			}
			des += "</font>";
			txtTweenProp.htmlText = tweens.length>0?des:"无";
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
		
		private function handleStarChange(refushId:Boolean=true):void
		{
			var type:int = comTigglerType.selectedIndex;
			if(type == EffectPlayTiggerType.PlayComplete)
			{
				boxTigglerParam.visible = true;
				if(refushId)
				{
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
				}
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
					selectItem.move.type = (selectItem.effOwnerType==EffectPlayOwnerType.Sender || selectItem.effOwnerType == EffectPlayOwnerType.MyTeam || selectItem.effOwnerType == EffectPlayOwnerType.ShengWu)?EffectPlayOwnerType.Target:EffectPlayOwnerType.Sender;
//					selectItem.move.rotation = true;
					selectItem.move.speed = 500;
					toBind(_moveBindData, selectItem.move);
					handleMoveTypeChange();
				}
				boxEndParam.visible = false;
			}else if(type == EffectPlayEndType.Time)
			{
				boxEndParam.visible = true;
				txtEndParamDes.text = "结束时间：";
				if(int(inputEndParam.text)<=0)
				{
					selectItem.endParam = 1000;
					toBind(_itemBindData, selectItem);
				}
			}else if(type == EffectPlayEndType.Plug)
			{
				boxEndParam.visible = true;
				txtEndParamDes.text = "插件ID：";
				if(!inputEndParam.text)
				{
					TipMsg.show("设置插件Id不能为空");
				}
			}
		}
		
		private function handleRefushScene(e:Event=null):void
		{
			if(!_effectPlayItemDatas)return;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			if(selectItem.disInfo.data){
				var endType:String = selectItem.disInfo.data.substr(-4);
				if(endType == "_png" || endType == "_jpg" || endType == ".png" || endType == ".jpg")
				{
					selectItem.disInfo.type = EffectPlayDisplayType.Image; 
				}else{
					selectItem.disInfo.type = EffectPlayDisplayType.MovieClip;
				}
			}
			ToolsApp.effectPlayer.playItem(selectItem, true);
			var items:Vector.<EffectPlayItem> = ToolsApp.effectPlayer.items;
			if(items.length>0 && items[0].display is Avatar)
				handleSetCanUseDir(Avatar(items[0].display));
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
			handlePlayItem();
		}
		
		private function handleCheckMoveType(index:int):Boolean
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return false;
			if(selectItem.effOwnerType == EffectPlayOwnerType.None)
			{
				TipMsg.show("当前没有设定拥有者");
				return false;
			}
			else if(selectItem.effOwnerType == index)
			{
				TipMsg.show("移动类型与拥有者类型相同， 请确保设置偏移，否则可能不会移动");
//				return false;
			}
			else if(selectItem.effOwnerType == EffectPlayOwnerType.OneTarget && index == EffectPlayOwnerType.Target)
			{
				TipMsg.show("移动类型与拥有者类型相同， 请确保设置偏移，否则可能不会移动");
//				return false;
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
		
		private function handleIdNameChange():void
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
				else if(role.avaterType == EffectPlayOwnerType.Sender || role.avaterType == EffectPlayOwnerType.MyTeam || role.avaterType == EffectPlayOwnerType.ShengWu)
				{	
					if(selectItem.effOwnerType ==EffectPlayOwnerType.Sender || selectItem.effOwnerType ==EffectPlayOwnerType.MyTeam || role.avaterType == EffectPlayOwnerType.ShengWu)
					{	
						item = ToolsApp.effectPlayer.getEffectPlayItem(selectItem.id);
						if(!item || !item.display)return;
						pos2 = item.display.localToGlobal(_tempZeroPoint); 
						selectItem.offx = (pos2.x - pos1.x);
						selectItem.offy = (pos2.y - pos1.y);
						toBind(_itemBindData, selectItem);
					}
				}else if(role.avaterType == EffectPlayOwnerType.Target || selectItem.effOwnerType ==EffectPlayOwnerType.OneTarget)
				{
					item = ToolsApp.effectPlayer.getEffectPlayItem(selectItem.id, role);
					if(!item || !item.display)return;
					pos2 = item.display.localToGlobal(_tempZeroPoint);	
					selectItem.offx = (pos2.x - pos1.x);
					selectItem.offy = (pos2.y - pos1.y);
					toBind(_itemBindData, selectItem);
				}
			}else if(display is Effect || display is EffectImage){
				var eff:DisplayObject = display as DisplayObject;
				item = ToolsApp.effectPlayer.getEffectPlayByDisplay(eff);
				if(!item)return;
				
				if(selectItem.effOwnerType == EffectPlayOwnerType.Sender ||selectItem.effOwnerType == EffectPlayOwnerType.OneTarget || selectItem.effOwnerType == EffectPlayOwnerType.MyTeam)//|| role.avaterType == EffectPlayOwnerType.ShengWu)
					target = item.owner;
				else if(selectItem.effOwnerType == EffectPlayOwnerType.Target)
					target = item.target;
				if(!target)return;
				pos2 = eff.localToGlobal(_tempZeroPoint);
				if(selectItem.useScreen)
				{
					var view:CenterView = ToolsApp.view.centerView; 
					pos1 = view.localToGlobal(new Point(view.width/2, view.height/2));
				}else{
					pos1 = target.localToGlobal(_tempZeroPoint);
				}
				if(selectItem.offXType != EffectPlayOffsetType.NONE)
				{
					Log.log("只有固定高度的时候才能拖动X特效");
				}else{
					selectItem.offx = (pos2.x - pos1.x);
				}
				if(selectItem.offXType != EffectPlayOffsetType.NONE)
				{
					Log.log("只有固定高度的时候才能拖动Y特效");
				}else{
					selectItem.offy = (pos2.y - pos1.y);
				}
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
			var data:EffectGroupItemData = e.data as EffectGroupItemData;
			if(!data)return;
			_effectPlayItemDatas = data.data;
			listStep.dataSource = _effectPlayItemDatas;
			if(_effectPlayItemDatas.length>0)
			{
				listStep.selectedIndex = 0;
				handleSelectStep();
			}else{
				ToolsApp.effectPlayer.clearAll();
			}
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
			handleSelectStep();
		}
		
		private function handleSelectStep(e:MouseEvent=null):void
		{
			if(!_effectPlayItemDatas)return;
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			ToolsApp.projectData.curEffectPlayItemData = selectItem;
			if(!selectItem)return;
			if(e)
			{
				Log.log("当前选择 特效项: "+selectItem.id);
				ToolsApp.projectData.fouceData = selectItem;
			}
			toBind(_itemBindData, selectItem);
			toBind(_moveBindData, selectItem.move);
			toBind(_disPlayBindData, selectItem.disInfo);
			ToolsApp.effectPlayer.playItem(selectItem, true);
			onDisplayTypeChange();
			handleStarChange(false);
			handleEndChange();
			refushTweenDes();
			handleRotationTypeChange(false);
			var items:Vector.<EffectPlayItem> = ToolsApp.effectPlayer.items;
			if(items.length>0 && items[0].display is Avatar)
				handleSetCanUseDir(Avatar(items[0].display));
			boxMove.visible = comMoveTo.selectedIndex != EffectPlayOwnerType.None;  
			SimpleEvent.send(AppEvent.EFFECT_STEP_CHANGE, selectItem);
			if(_setTweenView && _setTweenView.stage)
			{
				_setTweenView.open(selectItem);
			}
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
				if(selectItem.disInfo.dir == Direction.TO_TARGET_DIR || selectItem.disInfo.dir == Direction.TO_TARGET_ONE_DIR)//需要重置下对象
				{
					ToolsApp.effectPlayer.playItem(selectItem);
				}else{
//					ToolsApp.effectPlayer.refushDisplay();	
					ToolsApp.effectPlayer.playItem(selectItem);
				}
				if(selectItem.rotationType != RotationType.COSTOM)
				{
					ToolsApp.effectPlayer.refushRotation();
				}
				
				toBind(_disPlayBindData, selectItem.disInfo);
			}
//			else if(e.data == "move")
//			{
//				ToolsApp.effectPlayer.doMove();
//			}
		}
		
		private function handleRotationTypeChange(refushScene:Boolean=true):void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
//			inputRotation.visible = selectItem.rotationType == RotationType.COSTOM;
			txtRotationOffsetDes.visible = selectItem.rotationType != RotationType.COSTOM;
			if(refushScene)
				ToolsApp.effectPlayer.playItem(selectItem, true);
		}
		
		private function handleRefushRotation():void
		{
			var selectItem:EffectPlayItemData = listStep.selectedItem as EffectPlayItemData;
			if(!selectItem)return;
			ToolsApp.effectPlayer.refushRotation();
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
//			comDisDir.labels = dirStrs.join(",");//会重置索引为-1
			var newIdx:int = _dir2Dirindex[dir];
			comDisDir.setLabelsAndSelectIdx(dirStrs.join(","),newIdx); 
			
			if((dir == Direction.OWNER_DIR || dir == Direction.TO_TARGET_DIR || dir == Direction.TO_TARGET_ONE_DIR) )
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
//			var newIdx:int = _dir2Dirindex[dir];
//			if(newIdx != comDisDir.selectedIndex)
//				comDisDir.selectedIndex = newIdx;
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
			handleSelectStep();
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
			handleSelectStep();
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
		
		public function past(value:ICopyData):void
		{
			if(value is EffectPlayItemData)
			{
				if(!_effectPlayItemDatas)return;
				var item:EffectPlayItemData = value as EffectPlayItemData;
				item.id = getNewId();
				_effectPlayItemDatas.push(item);
				Log.log("粘贴  特效项："+item.id);
				listStep.dataSource = _effectPlayItemDatas;
				listStep.selectedIndex = _effectPlayItemDatas.length -1;
			}
		}
		
		private var _mask:Shape;
		public function onResize(w:int, h:int):void
		{
			if(!_mask)
			{
				_mask = new Shape();
				this.addChild(_mask);
				this.mask = _mask;
			}
			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000, 0.5);
			_mask.graphics.drawRect(0, 0, w, h-1);
			_mask.graphics.endFill();
			listStep.height = Math.max(1, h-5-listStep.y);
			bg.width = w;
			bg.height = h;
		}
		
	}
}