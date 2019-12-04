package com.cyj.app.view.app
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.Effect;
	import com.cyj.app.view.unit.Role;
	
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.net.dns.AAAARecord;
	
	public class RoleLayer extends Sprite
	{
		private var _targets:Vector.<Role> = new Vector.<Role>();
		private var _owner:Role;
		private var _all:Vector.<Role> = new Vector.<Role>();
		
		public function RoleLayer()
		{
			super();
			SimpleEvent.on(AppEvent.AVATER_TYPE_CHANGE, handleRoleTypeChange);
		}
		
		public function addRole(role:Role):void
		{
//			if(!_owner)//测试先写死
//			{
//				_owner = role;
//				if(role.avaterType!= EffectPlayOwnerType.Sender)
//				{
//					TipMsg.show("当前没有攻击者，所以将他设置为攻击者");
//					role.avaterType = EffectPlayOwnerType.Sender;
//				}
//			}else if(role.avaterType == EffectPlayOwnerType.Sender){
//				TipMsg.show("将之前的攻击者变更为受击者");
//				_owner.avaterType =EffectPlayOwnerType.Target;
//				_owner = role;
//				role.avaterType = EffectPlayOwnerType.Sender;
//			}else{
//				_targets.push(role);
//			}
			if(!_owner && _targets.length==0 && role.avaterType != EffectPlayOwnerType.Sender)
			{
				role.avaterType = EffectPlayOwnerType.Sender;
				TipMsg.show("第一个角色默认为施法者");
			}
			role.bodyMouseEnable = _roleMouseEnable;
			roleTypeChange(role);
			this.addChild(role);
		}
		
		public function removeRole(role:Avatar):void
		{
			if(_owner == role)
			{
				_owner = null;
			}else{
				var index:int = _targets.indexOf(role);
				if(index != -1)
				{
					_targets.splice(index, 1);
				}
				index = _all.indexOf(role);
				if(index != -1)
				{
					_all.splice(index , 1);
				}
			}
			if(this.contains(role))
				this.removeChild(role);
		}
		
		public function get owner():Role
		{
			return _owner;
		}
		
		public function get targets():Vector.<Role>
		{
			return _targets;
		}
		
		private function handleRoleTypeChange(e:SimpleEvent):void
		{
			var role:Role = e.data as Role;
			roleTypeChange(role);
		}
		private function roleTypeChange(role:Role):void
		{
			if(!role)return;
			if(role == _owner && role.avaterType == EffectPlayOwnerType.Sender)return;
			var index:int = _targets.indexOf(role);
			if(index!=-1 &&  role.avaterType == EffectPlayOwnerType.Target)return;
			if(role == _owner)
			{
				_owner = null;
				TipMsg.show("当前没有施法者,请重新设置一个施法者");
			}else if(index!=-1){
				_targets.splice(index, 1);
			}
			if(role.avaterType == EffectPlayOwnerType.Sender)
			{
				if(_owner)
				{
					_owner.avaterType = EffectPlayOwnerType.Target;
					_targets.push(_owner);
					TipMsg.show("替换之前的施法者 为受击者");
				}
				_owner = role;
			}else if(role.avaterType == EffectPlayOwnerType.Target)
			{
				_targets.push(role);
			}
			index = _all.indexOf(role);
			if(index == -1)
			{
				_all.push(role);
			}
		}
		
		public function get all():Vector.<Role>{
			return _all;
		}
		
		private var _lightRole:Role;
		public function onAddAvtMouseMove(stageX:int, stageY:int):void
		{
			var lightRole:Role = getRoleByStagePos(stageX, stageY);
//			var localPoint:Point = this.globalToLocal(new Point(stageX, stageY));
//			var color:int;
//			if(_owner.boundRect.containsPoint(localPoint))
//			{
//				lightRole = _owner;
//				color = 0x00ff00;
//			}else{
//				for(var i:int=0; i<_targets.length; i++)
//				{
//					if(_targets[i].boundRect.containsPoint(localPoint))
//					{
//						lightRole = _targets[i];
//						color = 0xff0000;
//						break;
//					}
//				}
//			}
			if(_lightRole != lightRole)
			{
				if(_lightRole)
				{
					_lightRole.filters = null;
					_lightRole = null;
				}
				if(lightRole)
				{
					var color:int = lightRole.getColor();
					
					_lightRole = lightRole;
					_lightRole.filters = [new GlowFilter(color, 1, 8, 8)];	
				}
			}
		}
		
		public function getRoleByStagePos(stageX:int, stageY:int):Role
		{
			var localPoint:Point = this.globalToLocal(new Point(stageX, stageY));
			var color:int;
			if(_owner && _owner.boundRect.containsPoint(localPoint))
			{
				return _owner;
			}else{
				for(var i:int=0; i<_targets.length; i++)
				{
					if(_targets[i].boundRect.containsPoint(localPoint))
					{
						return  _targets[i];
					}
				}
			}
			return null;
		}
		
		private var _roleMouseEnable:Boolean = true;
		public function set roleMouseEnable(value:Boolean):void
		{
			_roleMouseEnable = value;
			for(var i:int=0; i<_all.length; i++)
			{
				_all[i].bodyMouseEnable = _roleMouseEnable;
			}
		}
		public function get roleMouseEnable():Boolean
		{
			return _roleMouseEnable;
		}
		
		public function onAddAvtStopMove():void
		{
			if(_lightRole)
			{
				_lightRole.filters = null;
				_lightRole = null;
			}
		}
	}
}