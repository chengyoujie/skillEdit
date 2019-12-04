package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.view.app.effect.EffectPlayItem;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.ui.app.RoleOperUI;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.Effect;
	import com.cyj.app.view.unit.Role;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import morn.core.components.Button;
	import morn.core.handlers.Handler;
	
	public class RoleOper extends RoleOperUI
	{
		private var _avt:Avatar;
		private var _dirCtrShow:Boolean = true;//在createChildre中会取反下
		private var _actArr:Array = [Action.ACTION_TYPE_STAND, Action.ACTION_TYPE_MOVE, Action.ACTION_TYPE_ACT];
		private var _actBtnDic:Object = {};
		private var _loopBind:BindData;
		private var _layerBind:BindData;
		private var _ownerBind:BindData;
		private var _rect:Rectangle = new Rectangle(0, 0, 10, 10);
		
		public function RoleOper()
		{
			super();
			this.mouseEnabled = true;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			btnDown.clickHandler = new Handler(handleChangeDir, [Direction.BOTTOM]);
			btnLeft.clickHandler = new Handler(handleChangeDir, [Direction.LEFT]);
			btnRight.clickHandler = new Handler(handleChangeDir, [Direction.RIGHT]);
			btnUp.clickHandler = new Handler(handleChangeDir, [Direction.TOP]);
			btnUpRight.clickHandler = new Handler(handleChangeDir, [Direction.RIGHTTOP]);
			btnLeftUp.clickHandler = new Handler(handleChangeDir,[ Direction.LEFTTOP]);
			btnOwnerDir.clickHandler = new Handler(handleChangeDir,[ Direction.OWNER_DIR]);
			btnTargetDir.clickHandler = new Handler(handleChangeDir,[ Direction.TO_TARGET_DIR]);
			btnLeftDown.clickHandler = new Handler(handleChangeDir, [Direction.LEFTBOTTOM]);
			btnRightDown.clickHandler = new Handler(handleChangeDir, [Direction.RIGHTBOTTOM]);
			comRoleType.selectHandler = new Handler(handleTypeChange);
			comAct.selectHandler = new Handler(handleActChange);
			btnHide.clickHandler = new Handler(handleDirCtrShow);
			
			_actBtnDic[Direction.BOTTOM] = btnDown;
			_actBtnDic[Direction.LEFT] = btnLeft;
			_actBtnDic[Direction.RIGHT] = btnRight;
			_actBtnDic[Direction.TOP] = btnUp;
			_actBtnDic[Direction.RIGHTTOP] = btnUpRight;
			_actBtnDic[Direction.LEFTTOP] = btnLeftUp;
//			_actBtnDic[Direction.OWNER_DIR] = btnOwnerDir;
			_actBtnDic[Direction.LEFTBOTTOM] = btnLeftDown;
			_actBtnDic[Direction.RIGHTBOTTOM] = btnRightDown;
			
			_loopBind = new BindData(inputLoop, "loop", "text", handleLoopChange),
			_layerBind = new BindData(comLayer, "layer", "selectedIndex", handleRefushLayer),
			_ownerBind = new BindData(comOwner, "effOwnerType", "selectedIndex", handleRefushOwner),
			
			handleDirCtrShow();
			_rect.width = this.width;
			_rect.height = this.height;
		}
		
		private function handleCheckClick(e:MouseEvent):void
		{
			var localPos:Point = this.globalToLocal(new Point(e.stageX, e.stageY));
			if(!this._rect.containsPoint(localPos))
			{
				_dirCtrShow = true;
				handleDirCtrShow();
			}
		}
		
		private function handleDirCtrShow():void
		{
			_dirCtrShow = !_dirCtrShow;
			boxDir.visible = _dirCtrShow;
			boxOper.visible = _dirCtrShow;
			btnHide.label = _dirCtrShow?"隐":"详";
			imgBg.visible = _dirCtrShow;
		}
		
		public function bind(avt:Avatar):void
		{
			_avt = avt;
			if(_avt is Role)
			{
				var role:Role = _avt as Role;
				boxRole.visible = true;
				boxEffect.visible = false;
				boxEffectOper.visible = false;
				imgBg.height = 60;
				comAct.selectedIndex = _actArr.indexOf(role.act);
				comRoleType.selectedIndex = role.avaterType;
			}else if(_avt is Effect)
			{
				boxRole.visible = false;
				boxEffect.visible = true;
				boxEffectOper.visible = true;
				imgBg.height = 80;
				bindEffect(Effect(_avt), ToolsApp.projectData.curEffectPlayItemData);
			}
			refushCanUseDir();
			App.stage.addEventListener(MouseEvent.CLICK, this.handleCheckClick );
		}
		
		private function bindEffect(eff:Effect, data:EffectPlayItemData):void
		{
			if(!eff || !data)return;
			_loopBind.bind(data.disInfo);
			_layerBind.bind(data);
			_ownerBind.bind(data);
		}
		
		private function handleRefushLayer():void
		{
			SimpleEvent.send(AppEvent.EFFECT_OPER_SET_CHANGE, "layer");
		}
		private function handleLoopChange():void
		{
			SimpleEvent.send(AppEvent.EFFECT_OPER_SET_CHANGE, "loop");	
		}
		private function handleRefushOwner():void
		{
			SimpleEvent.send(AppEvent.EFFECT_OPER_SET_CHANGE, "owner");	
		}
		
			
		
		private function handleChangeDir(dir:int):void{
			if(!_avt || _avt.isDispose)
			{
				TipMsg.show("当前绑定对象已失效,请重新打开操作界面");
				unbind();
				return;
			}
			if(_avt is Role)
			{
				_avt.dir = dir;	
				SimpleEvent.send(AppEvent.EFFECT_OPER_SET_CHANGE, "dir");	
			}else{
				var data:EffectPlayItemData = ToolsApp.projectData.curEffectPlayItemData;
				if(!data)return;
				data.disInfo.dir = dir;
				SimpleEvent.send(AppEvent.EFFECT_OPER_SET_CHANGE, "dir");	
			}
			
		}
		
		private function handleTypeChange(index:int):void
		{
			if(_avt is Role)
			{
				var role:Role = _avt as Role;
				role.avaterType = index;
				SimpleEvent.send(AppEvent.AVATER_TYPE_CHANGE, role);
			}
		}
		
		public function get target():Avatar
		{
			return _avt;
		}
		
		public function unbind():void
		{
			this.visible = false;
			_loopBind.unBind();
			_layerBind.unBind();
			_ownerBind.unBind();
			App.stage.removeEventListener(MouseEvent.CLICK, this.handleCheckClick );
			_avt = null;
		}
		
		
		private function handleActChange(index:int):void
		{
			if(!_avt || _avt.isDispose)return;
			_avt.act = _actArr[index];
			refushCanUseDir();
		}
		
		private function refushCanUseDir():void
		{
			if(!_avt)return;
			var arr:Array = _avt.getActHaveDirs(_avt.act) || [];
			
			for(var dir:String in _actBtnDic)
			{
				var btn:Button = _actBtnDic[dir];
				var dir2:int =int(dir);
				btn.disabled = arr.indexOf(dir2)==-1 && arr.indexOf(Direction.getHaveResDir(dir2)) == -1;
			}
			if(arr.length>1)
			{
				btnTargetDir.disabled = btnOwnerDir.disabled = false;
			}else{
				btnTargetDir.disabled = btnOwnerDir.disabled = true;
			}
		}
		
	}
}