package com.cyj.app.view.app.effect
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.AvaterData;
	import com.cyj.app.data.cost.Action;
	import com.cyj.app.data.cost.Direction;
	import com.cyj.app.data.cost.EaseType;
	import com.cyj.app.data.cost.EffectPlayDisplayType;
	import com.cyj.app.data.cost.EffectPlayEndType;
	import com.cyj.app.data.cost.EffectPlayLayer;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.data.cost.EffectPlayTiggerType;
	import com.cyj.app.data.cost.RotationType;
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.data.effect.EffectPlayMoveEndData;
	import com.cyj.app.data.effect.EffectPlayTweenPropData;
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.app.CenterView;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.common.TipMsg;
	import com.cyj.app.view.unit.Avatar;
	import com.cyj.app.view.unit.Effect;
	import com.cyj.app.view.unit.EffectImage;
	import com.cyj.app.view.unit.Role;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	

	public class EffectPlayItem
	{
		private var _display:DisplayObjectContainer;
		private var _lastDisplayType:int=-1;
		private var _data:EffectPlayItemData;
		private var _centerView:CenterView;
		private var _target:Role;
		private var _owner:Role;
		private var _endFun:Function;
		private var _isPlaying:Boolean  = false;
		private var _mouseEnable:Boolean = true;
//		private var _img:EffectImage;
//		private var avt:Avatar;
		
		public function EffectPlayItem()
		{
			_centerView = ToolsApp.view.centerView;
		}
		
		public function setData(data:EffectPlayItemData, owner:Role, target:Role):void
		{
			_data = data;
			_owner = owner;
			_target = target;
		}
		
		public function get data():EffectPlayItemData
		{
			return _data;
		}
		
//		public function setTarget():void
//		{
//			_sender = sender;
//			_target = target;
//			refushContain();
//		}
		
		public function play(endFun:Function):void
		{
			if(!_data)return;
			_endFun = endFun;
			_isPlaying = true;
			if(_endFun !=null && _data.delay>0)
			{
				if(_data.delayRandom)
				{
					App.timer.doOnce(_data.delay*Math.random(), run);
				}else{
					App.timer.doOnce(_data.delay, run);	
				}
			}else{
				run();
			}
		}	
		private function run():void
		{
			if(!_data)return;
			App.timer.clearTimer( run);
			refushDisplay();
			doMove();
			refushTween();
			if(_data.endType == EffectPlayEndType.Time)
			{
				App.timer.doOnce(_data.endParam, end);
			}else if(_data.endType == EffectPlayEndType.EffectPlayComplete){
				if(_display is Avatar)
				{
					if(_endFun != null)
						Avatar(_display).doLoop(_data.disInfo.loop, end);
					else
						Avatar(_display).doLoop(0, null);
				}else{
					Alert.show(_data.id+"不能设置EffectImage为播放完成");
				}
			}//移动在tween中设置了
		}
		
		private function end():void
		{
			if(_endFun != null)
				_endFun(this);
			_endFun = null;
			_isPlaying = false;
		}
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		public function refushDisplay():void
		{
			if(!_data || !_data.disInfo)return;
			var caster:Avatar = getCaster(_data.effOwnerType);
			if(_data.disInfo.type != _lastDisplayType)
			{
				if(_display is Avatar)
				{
					Avatar(_display).dispose();
				}else if(_display is EffectImage){
					EffectImage(_display).dispose();
				}
				if(_data.disInfo.type == EffectPlayDisplayType.Image)
				{
					_display = new EffectImage();
					EffectImage(_display).path = ToolsApp.projectData.getImagePathByName(_data.disInfo.data);
				}else{
					var path:Object = ComUtill.getAvtResPath(_data.disInfo.data);
					var effData:AvaterData = new AvaterData(path.path, path.isDirRes);
					_display = new Effect(effData);
					var dir:int = _data.disInfo.dir;
//					if(dir == Direction.OWNER_DIR)
//					{
//						if(caster)
//							dir = caster.dir;
//						else
//							dir = Direction.TOP;
//					}else if(dir == Direction.TO_TARGET_DIR)
//					{
//						if(_target)
//						{
//							dir = Direction.getDir(caster, caster==_owner?_target:_owner);
//						}
//					}
//					Avatar(_display).dir =dir ;
					refushDir();
					if(_endFun != null)
						Avatar(_display).doLoop(_data.disInfo.loop, end);
				}
				mouseEnable = _mouseEnable;//刷新状态
				refushContain();
			}else{
				if(_display is Avatar)
				{
					var pathInfo:Object = ComUtill.getAvtResPath(_data.disInfo.data);
					Avatar(_display).isDirRes = pathInfo.isDirRes;
					Avatar(_display).path = pathInfo.path;
//					var dir2:int = _data.disInfo.dir;
//					if(dir2 == Direction.OWNER_DIR)
//					{
//						if(caster)
//							dir2 = caster.dir;
//						else
//							dir2 = Direction.TOP;
//					}else if(dir2 == Direction.TO_TARGET_DIR)
//					{
//						if(_target)
//						{
//							dir2 = Direction.getDir(caster, caster==_owner?_target:_owner);
//						}
//					}
//					Avatar(_display).dir = dir2;
					refushDir();
					if(_endFun != null)
						Avatar(_display).doLoop(_data.disInfo.loop, end);
//					Avatar(_display).loop = _data.disInfo.loop;
				}else{
					EffectImage(_display).path =ToolsApp.projectData.getImagePathByName(_data.disInfo.data);
				}
			}
			_lastDisplayType = _data.disInfo.type;
		}
		
		private function refushDir():void
		{
			if(!_data || !_data.disInfo)return;
			if(!(_display is Avatar))return;
			var caster:Avatar = getCaster(_data.effOwnerType);
			if(!caster)return;
			var dir2:int = _data.disInfo.dir;
			if(dir2 == Direction.OWNER_DIR)
			{
				if(caster)
					dir2 = caster.dir;
				else
					dir2 = Direction.TOP;
			}else if(dir2 == Direction.TO_TARGET_DIR)
			{
				if(_target)
				{
					var pos:Point = new Point();
					var casterPos:Point = _display.localToGlobal(pos);
					var targetPos:Point =  Role(caster==_owner?_target:_owner).localToGlobal(pos);
					dir2 = Direction.getDir(casterPos, targetPos);
				}
			}
			Avatar(_display).dir = dir2;
		}
		
		
		private var _tempPoint:Point = new Point();
		private var _tempPoint2:Point = new Point();
		private var _tween:TweenLite;
		public function doMove():void
		{
			if(!_data)return;
			if(_tween)
			{
				_tween.kill();
				_tween = null;
			}
			refushPos();
			var move:EffectPlayMoveEndData = _data.move;
			var pos:Point = _tempPoint;
			pos.x = 0;
			pos.y = 0;
			if(move && move.type != EffectPlayOwnerType.None)
			{
				_display.rotation = 0;
				var toRole:Avatar = getCaster(move.type);
				var fromRole:Avatar = getCaster(_data.effOwnerType);
				if(_data.effOwnerType == EffectPlayOwnerType.OneTarget)
				{
					toRole = _target;
				}
				if(fromRole && toRole )
				{
					_tempPoint2.x = 0;
					_tempPoint2.y = 0;
					_tempPoint2 = toRole.localToGlobal(_tempPoint2);//角色的坐标转为特效的坐标
					_tempPoint2 = _display.globalToLocal(_tempPoint2);
					pos.x += _tempPoint2.x;
					pos.y += _tempPoint2.y;
					if(move.distance)
					{
						var angle:Number = Math.atan2(-fromRole.y+toRole.y, -fromRole.x+toRole.x);
						pos.x +=(move.distance)*Math.cos(angle);
						pos.y  +=  (move.distance)*Math.sin(angle);
					}
				}
				pos.x += _display.x;
				pos.y += _display.y;
//				if(move.rotation)
//					_display.rotation = ComUtill.getAngle(_display, pos)/Math.PI*180;
				refushRotation();
				var speed:int = move.speed || 1;
				var time:Number = ComUtill.getDistance(_display, pos, true)/speed;
				_display.mouseEnabled = false;
				var ease:Function = EaseType.getEase(move.ease);
				if(_data.endType == EffectPlayEndType.MoveEnd)
				{
					_tween = TweenLite.to(_display,time , {x:pos.x, y:pos.y, onComplete:onMoveEnd, "ease":ease})
				}else{
					_tween = TweenLite.to(_display, time , {x:pos.x, y:pos.y, onComplete:onMoveEnd, "ease":ease});
				}
			}
		}
		
		private function onMoveEnd():void
		{
			_display.mouseEnabled = true;
			if(_data.endType == EffectPlayEndType.MoveEnd)
			{
				end();
			}
			refushPos();
		}
		
		public function get display():DisplayObject
		{
			return _display;
		}
		public function get target():Role
		{
			return _target;
		}
		public function get owner():Role
		{
			return _owner;
		}
		
		public function refushRotation():void
		{
			if(!_data)return;
			if(!_display)return;
			if(_data.rotationType == RotationType.COSTOM)
			{
				_display.rotation = _data.rotation;
			}else if(_data.rotationType == RotationType.OWNER){
				_display.rotation = Direction.getDegrees(_owner.dir);
			}else if(_data.rotationType == RotationType.TARGET)
			{
				if(_target)
				{
					var zeroPoint:Point = new Point();
					var pos1:Point = _target.localToGlobal(zeroPoint);
					var pos2:Point = _display.localToGlobal(zeroPoint);
					_display.rotation = ComUtill.getAngle(pos2, pos1)/Math.PI*180;
				}
			}
		}
		
		
		public function refushContain():void
		{
			if(!_data)return;
			if(!_display)return;
			if(_display.parent)
				_display.parent.removeChild(_display);
			var caster:Avatar = getCaster(_data.effOwnerType);
			if(_data.layer == EffectPlayLayer.Top)
			{
				_centerView.upLayer.addChild(_display);
			}else if(_data.layer == EffectPlayLayer.Bottom)
			{
				_centerView.downLayer.addChild(_display);
			}else if(_data.layer == EffectPlayLayer.RoleTop)
			{
				if(caster)
					caster.upLayer.addChild(_display);
				else{
					TipMsg.show("不能添加到角色顶部, 因为没有设置该项的目标");
				}
			}else if(_data.layer == EffectPlayLayer.RoleBottom)
			{
				if(caster)
					caster.downLayer.addChild(_display);
				else{
					TipMsg.show("不能添加到角色底部, 因为没有设置该项的目标");
				}
			}
			else if(_data.layer == EffectPlayLayer.FiveDir)
			{
				if(caster)
				{
					var layer:Sprite = _centerView.getSceneLayerByDir(caster.dir);
					layer.addChild(_display);
				}
				else{
					TipMsg.show("不能添加五方向, 因为没有设置该项的目标");
				}
			}
			if(_display is Avatar)
			{
				Avatar(_display).refushRes();
			}
			refushPos();
		}
		
		public function refushPos():void
		{
			if(!_data || !_display)return;
			var useCasterPos:Boolean = false;//是否使用 角色坐标
			if(_data.layer == EffectPlayLayer.Top || _data.layer == EffectPlayLayer.Bottom || _data.layer == EffectPlayLayer.FiveDir)
			{
				useCasterPos = true;
			}
			var caster:Avatar = getCaster(_data.effOwnerType);
			if(caster && useCasterPos)
			{
				_display.x = caster.x+_data.offx;
				_display.y = caster.y+_data.offy;
			}else{
				_display.x = _data.offx;
				_display.y = _data.offy;
			}
			if(_display is Avatar)
			{
				Avatar(_display).scalex = _data.scalex;
				Avatar(_display).scaley = _data.scaley;
			}else{
				_display.scaleX = _data.scalex;
				_display.scaleY = _data.scaley;
			}
			
//			if(_data.move.type != EffectPlayOwnerType.None && _data.move.rotation)
//			{
//				var target:DisplayObject = caster==_owner?_target:_owner;
//				if(target)
//				{
//					var zeroPoint:Point = new Point();
//					var pos1:Point = target.localToGlobal(zeroPoint);
//					var pos2:Point = _display.localToGlobal(zeroPoint);
//					_display.rotation = ComUtill.getAngle(pos2, pos1)/Math.PI*180;
//				}
//			}
			refushDir();
			refushRotation();
		}
		
		public function refushTween():void
		{
			if(!_display)return;
			if(!_data)return;
			for(var i:int=0; i<_data.tweenProps.length; i++)
			{
				var item:EffectPlayTweenPropData = _data.tweenProps[i];
				var prop:String = item.prop;
				if(!_display.hasOwnProperty(prop))continue;
				_display[item.prop] = item.from;
				var ease:Function = EaseType.getEase(item.type);
				var tweenData:Object = { "ease":ease};
				tweenData[prop] = item.to;
				TweenMax.to(_display, item.time/1000, tweenData)
			}
		}
		
		public function set mouseEnable(value:Boolean):void
		{
			_mouseEnable = value;
			if(_display)//不能设置mouseChildren = true 否则导致点击的时候点到effect内部的movie导致无法判断
				_display.mouseEnabled = _mouseEnable;
		}
		public function get mouseEnable():Boolean
		{
			return _mouseEnable;
		}
		
		private function getCaster(type:int):Avatar
		{
			if(type == EffectPlayOwnerType.None)return null;
			else if(type == EffectPlayOwnerType.Target)return _target;
			else if(type == EffectPlayOwnerType.Sender || type == EffectPlayOwnerType.OneTarget)return _owner;
			return null;
		}
		
		public function remove():void
		{
			if(!_display)return;
			if(_display.parent)
				_display.parent.removeChild(_display);
			if(_tween)
			{
				_tween.kill();
				_tween = null;
			}
		}
		
		public function dispose():void
		{
			remove();
			_isPlaying = false;
			if(_display is Avatar)
			{
				Avatar(_display).dispose();
			}else if(_display is EffectImage){
				EffectImage(_display).dispose();
			}
			App.timer.clearTimer(end);
			_data = null;
			_target = null;
			_owner = null;
			_display = null;
		}
		 
		
	}
}