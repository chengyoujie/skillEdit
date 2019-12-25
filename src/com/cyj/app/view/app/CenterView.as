package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.AvaterData;
	import com.cyj.app.data.FrameData;
	import com.cyj.app.data.FrameItemData;
	import com.cyj.app.data.ICopyData;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.EffectPlayDisplayType;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.app.effect.EffectPlayer;
	import com.cyj.app.view.app.movectr.MoveControl;
	import com.cyj.app.view.app.movectr.MoveControlCell;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.common.edit.EditAvater;
	import com.cyj.app.view.common.edit.EditBlock;
	import com.cyj.app.view.common.edit.EditDisplayObject;
	import com.cyj.app.view.ui.app.CenterViewUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.AvaterRes;
	import com.cyj.app.view.unit.DragImage;
	import com.cyj.app.view.unit.Effect;
	import com.cyj.app.view.unit.EffectImage;
	import com.cyj.app.view.unit.Movie;
	import com.cyj.app.view.unit.MoviePlay;
	import com.cyj.app.view.unit.Role;
	import com.cyj.app.view.unit.SubImageInfo;
	import com.cyj.utils.Log;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import morn.core.handlers.Handler;
	
	public class CenterView extends CenterViewUI
	{
		
		private var _res:AvaterRes;
		private var _frame:int;
		
		private var _editContain:Sprite;
		private var _editDic:Dictionary = new Dictionary();
		private var _curEdit:EditDisplayObject;
		private var _moveOffPos:Point = new Point();
		private var _curDragObj:DisplayObject;
//		private var _avtId:int = 0;
		private var _avt2IdDic:Dictionary = new Dictionary();
		
		private var _roleOper:RoleOper;
		
		public var roleLayer:RoleLayer;
		
		public var moveLayer:Sprite;
		
		public var upLayer:Sprite;
		public var downLayer:Sprite;
		private var _moveControls:Vector.<MoveControl> = new Vector.<MoveControl>();

		
		public function CenterView()
		{
			super();
			this._width = Number.NaN;
			this._height = Number.NaN;
			downLayer = new Sprite();
			addChild(downLayer);
			
			roleLayer = new RoleLayer();
			this.addChild(roleLayer);
			
			upLayer = new Sprite();
			addChild(upLayer);
			
			moveLayer = new Sprite();
			addChild(moveLayer);
			
			_editContain = new Sprite();
			this.addChild(_editContain);
			
			_roleOper = new RoleOper();
			this.addChild(_roleOper);
			_roleOper.visible = false;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			SimpleEvent.on(AppEvent.CLICK_ROLE, handleClickRole);
			SimpleEvent.on(AppEvent.EFFECT_STEP_CHANGE, handleEffectStepChange);
//			SimpleEvent.on(AppEvent.REFUSH_SCENE, handleEffectStepChange);
			SimpleEvent.on(AppEvent.MOVE_CHANGE, handleDistanceChange);
//			btnPlay.clickHandler = new Handler(handlePlayAll);
			checkLockEffect.clickHandler = new Handler(handleLockEffect);
			checkLockRole.clickHandler = new Handler(handleLockRole);
//			btnRefush.clickHandler = new Handler(handleRefush);
		}
		
		private function handlePlayAll():void
		{
			ToolsApp.effectPlayer.play();
		}
		
		public function initView():void
		{
			initAvatar();
		}
		
		private function handleLockEffect():void
		{
			checkLockEffect.selected = ToolsApp.effectPlayer.mouseEnable;
			upLayer.mouseEnabled = downLayer.mouseEnabled = ToolsApp.effectPlayer.mouseEnable = !checkLockEffect.selected;
		}
		
		private function handleLockRole():void
		{
			checkLockRole.selected = roleLayer.roleMouseEnable;
			roleLayer.mouseEnabled = roleLayer.roleMouseEnable = !checkLockRole.selected ;
		}
		
		public function initProject():void
		{
		}
		
		private function initAvatar():void
		{
			var avts:Array = ToolsApp.localCfg.sceneAvater;
			var roles:Vector.<Role> = new Vector.<Role>();
			for(var i:int=0; i<avts.length; i++)
			{
				var info:AvaterData = avts[i] as AvaterData;
//				info.path, info.isDirRes, info.dir, info.act
				var avt:Avatar = new Role(info);
				avt.x = info.x;
				avt.y = info.y;
				if(info.type == EffectPlayOwnerType.Sender)
				{
					roles.unshift(avt);
				}else{
					roles.push(avt);
				}
//				if(info.id>_avtId)
//				{
//					_avtId = info.id+1;
//				}
			}
			for(i=0; i<roles.length; i++)
			{
				addAvatar(roles[i]);
			}
			//测试
//			var data1:AvaterData = new AvaterData("D:/publish//avatarres/body/1500", true);
//			var owner:Role = new Role(data1);
//			owner.x = 500;
//			owner.y  = 350;
//			owner.avaterType = EffectPlayOwnerType.Sender;
//			this.roleLayer.addRole(owner);
//			var data2:AvaterData =  new AvaterData("D:/publish//avatarres/monster/500", true);
//			var target:Role = new Role(data2);
//			target.x = 300;
//			target.y = 450;
//			target.avaterType = EffectPlayOwnerType.Target;
//			this.roleLayer.addRole(target);
//			var data3:AvaterData =  new AvaterData("D:/publish//avatarres/monster/500", true);
//			target = new Role(data3);
//			target.x = 500;
//			target.y = 450;
//			target.avaterType = EffectPlayOwnerType.Target;
//			this.roleLayer.addRole(target);
		}
		
		public function addAvatar(display:DisplayObject, dropTarget:Role=null):void
		{
			if(display is Role)
			{
				var avt:Role = display as Role;
				this.roleLayer.addRole(avt);	
				refushMoveList();
				SimpleEvent.send(AppEvent.REFUSH_SCENE);
			}else{
				var curEffectItemData:EffectPlayItemData = ToolsApp.projectData.curEffectPlayItemData;
				if(curEffectItemData)
				{
					if(curEffectItemData.disInfo.data)
					{
						Alert.show("当前已有资源是否替换", "提示", Alert.ALERT_OK_CANCLE, handleReplaceRes, "替换", "取消", {"display":display, "dropTarget":dropTarget});
					}else{
						SimpleEvent.send(AppEvent.ITEM_ADD_RES, {"display":display, "dropTarget":dropTarget});
					}
				}else{
					Alert.show("当前没有选择操作步骤，请先选择右侧的操作步骤");
				}
			}
		}
		
		private function handleReplaceRes(del:int, data:*):void
		{
			if(del == Alert.ALERT_OK)
			{
				SimpleEvent.send(AppEvent.ITEM_ADD_RES, data);
			}
		}
/////////////////////特效移动相关		
		/**特效的步改变**/
		private function handleEffectStepChange(e:SimpleEvent):void
		{
			if(_curEdit)
			{
				_curEdit.end();
				_curEdit = null;
			}
			if(_roleOper && _roleOper.visible)
			{
				if(!_roleOper.target || _roleOper.target.isDispose)
				{
					_roleOper.unbind();
				}
			}
			refushMoveList();
		}
		
		private function refushMoveList():void
		{
			clearMoveCtr();
			var data:EffectPlayItemData = ToolsApp.projectData.curEffectPlayItemData;
			if(data && data.move.type != EffectPlayOwnerType.None)
			{
				var roles:Vector.<Role> = roleLayer.targets;
				var owners:Vector.<Role> = new Vector.<Role>();
				owners.push(roleLayer.owner);
				if(roleLayer.owner && roles)
				{
					var targets:Vector.<Role>;
					var sends:Vector.<Role>;
					if(roles.length>0 && data.effOwnerType == EffectPlayOwnerType.OneTarget)
					{
						sends = new Vector.<Role>();
						sends.push(roles[0]);
						targets = owners;
					}else 
					if(data.effOwnerType == EffectPlayOwnerType.Sender){
						sends = owners;
						targets = roles;
					}else{
						sends = roles;
						targets = owners;
					}
					for(var i:int=0; i<sends.length; i++)
					{
						for(var m:int=0; m<targets.length; m++)
						{
							var move:MoveControl = new MoveControl();
							move.bind(sends[i], targets[m], data.move.distance);
							this.moveLayer.addChild(move);
							_moveControls.push(move);
						}
					}
				}
			}
		}
		
		private function handleDistanceChange(e:SimpleEvent):void
		{
			var itemData:EffectPlayItemData = ToolsApp.projectData.curEffectPlayItemData;
			if(itemData)
			{
				if(e.data == "distance")
					updateMoveCtrDistance(itemData.move.distance);
				else if(e.data == "type")
					refushMoveList();
			}
		}
		
		private function updateMoveCtrDistance(distance:int):void
		{
			for(var i:int=0; i<_moveControls.length; i++)
			{
				_moveControls[i].distance = distance;
			}
		}
		
		private function updateMoveCtr():void
		{
			for(var i:int=0; i<_moveControls.length; i++)
			{
					_moveControls[i].update();
			}
		}
		
		private function clearMoveCtr():void
		{
			while(_moveControls.length>0)
			{
				_moveControls.pop().dispose();
			}
		}
//鼠标操作相关		
		/** 根据方向获取特效添加层 */
		public function getSceneLayerByDir(dir: int):Sprite{
			return (dir == Direction.TOP || dir == Direction.LEFTTOP || dir == Direction.RIGHTTOP) ?downLayer : upLayer;
		}
		
		private function handleClickRole(e:SimpleEvent):void
		{
			handleClick(e.data.role as Avatar, e.data.stageX, e.data.stageY);
		}
		
		private function handleMouseDown(e:MouseEvent):void
		{
			handleClick(e.target as DisplayObject, e.stageX, e.stageY);
		}
		private function handleClick(avt:DisplayObject, stageX:Number, stageY:Number):void{
			
			if(_curEdit)
			{
				_curEdit.end();
				_curEdit = null;
//				_roleOper.visible = false;
			}
			if(!(avt is Avatar  ||  avt is EffectImage || avt is MoveControlCell))return;

			_curDragObj = avt;
			var edit:EditDisplayObject  = _editDic[avt];
			if(avt is Avatar)
			{
				Avatar(avt).stop();
				if(!edit)
				{
					edit = _editDic[avt] = new EditAvater(Avatar(avt), _editContain);
				}
				edit.start();
				_roleOper.visible = true;
				_roleOper.bind(Avatar(avt));
				if(avt is Role)
				{	
					Log.log("当前选择角色"+Avatar(avt).onlyId);
					ToolsApp.projectData.fouceData = Avatar(avt).data;
				}
			}else if(avt is EffectImage){
				if(!edit)
				{
					edit = _editDic[avt] = new EditDisplayObject(avt, _editContain);
				}
				Log.log("当前选择图片"+EffectImage(avt).path);
				ToolsApp.projectData.fouceData = EffectImage(avt).data;
				_roleOper.unbind();
				edit.start();
			}
			if(edit && _roleOper.visible)
			{
				_roleOper.x = edit.frameX;
				_roleOper.y = edit.frameY;
			}
			_curEdit = edit;
			_moveOffPos.x = stageX;
			_moveOffPos.y = stageY;
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		private function handleMouseMove(e:MouseEvent):void
		{
			if(!_curDragObj)return;
//			var avt:Avatar = _curDragObj as Avatar;
			var stageX:int = e.stageX;//在同一函数中调用可能是不同的值， 所以先存起来
			var stageY:int = e.stageY;
			if(_curDragObj)
			{
				if(_curDragObj is MoveControlCell)
				{
					var moveCell:MoveControlCell = _curDragObj as MoveControlCell;
					var moveCtr:MoveControl = moveCell.control;
					var otherCell:MoveControlCell = moveCtr.fromCell==moveCell?moveCtr.toCell:moveCtr.fromCell;
					moveCell.y += stageY - _moveOffPos.y;	
					var offx:int = otherCell.target.x-moveCell.target.x;
					var offy:int = otherCell.target.y-moveCell.target.y;
					moveCell.x = moveCell.target.x + (moveCell.y-moveCell.target.y)*offx/offy;
					moveCtr.updateLine();
//					updateMoveCtr(moveCell.control.distance);
				}else{
					_curDragObj.x = (stageX - _moveOffPos.x)+_curDragObj.x;
					_curDragObj.y = (stageY - _moveOffPos.y)+_curDragObj.y;	
				}
				_moveOffPos.x = stageX;
				_moveOffPos.y = stageY;
				var edit:EditDisplayObject  = _editDic[_curDragObj];
				if(edit)
				{
					edit.refushPos();
					if(_roleOper.visible)
					{
						_roleOper.x = edit.frameX;
						_roleOper.y = edit.frameY;
					}
				}
				
			}
			var info:Object = _avt2IdDic[_curDragObj];
			if(info)
			{
				info.x = _curDragObj.x;
				info.y = _curDragObj.y;
			}
			_moveOffPos.x = stageX;
			_moveOffPos.y = stageY;
		}
		
		private function handleMouseUp(e:MouseEvent):void
		{
			if(!_curDragObj)return;
			var avt:Avatar = _curDragObj as Avatar;
			if(avt)
			{
				avt.start();
			}
			if(_curDragObj is Role)
			{
				ToolsApp.effectPlayer.refushPos();
				updateMoveCtr();
			}
			//TODO 派发移动结束事件
			SimpleEvent.send(AppEvent.AVATER_MOVE, _curDragObj);
			_curDragObj = null;
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		public function onAddAvtMouseMove(stageX:int, stageY:int):void
		{
			roleLayer.onAddAvtMouseMove(stageX, stageY);
		}
		public function onAddAvtStopMove():void
		{
			roleLayer.onAddAvtStopMove();
		}
		
		public function getAddAvtRole(stageX:int, stageY:int):Role
		{
			return roleLayer.getRoleByStagePos(stageX, stageY);
		}

		
//键盘操作相关
		public function doDelete():void
		{
			if(_curEdit)
			{
				var role:Role = _curEdit.target as Role;
				if(role)
				{
					delete _editDic[role];
					roleLayer.removeRole(role);
					role.dispose();
					_curEdit.dispose();
					_curEdit = null;
					_roleOper.unbind();
					
					refushMoveList();
					SimpleEvent.send(AppEvent.REFUSH_SCENE);
				}
			}
		}
		
		private var _pastGap:int = 10;
		private var _lastPastRoleId:int = 0;
		public function past(value:ICopyData):void
		{
			if(value is AvaterData)
			{
				var avtData:AvaterData = value as AvaterData;
				var avt:Role = new Role(avtData);
				if(_lastPastRoleId == avtData.id)
					_pastGap += 10;
				else
					_pastGap = 10;
				avtData.x += _pastGap;
				avtData.y += _pastGap;
				avt.x = avtData.x;
				avt.y = avtData.y;
				addAvatar(avt);
				Log.log("粘贴 角色"+avtData.id);
			}
		}
		public function onResize(w:int, h:int):void
		{
			
			bg.width = w;
			bg.height = h;
		}
		
	}
}