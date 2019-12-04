package com.cyj.app.view.unit
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.data.AvaterData;
	import com.cyj.app.data.cost.EffectPlayOwnerType;
	import com.cyj.app.view.app.AppEvent;
	
	import flash.events.MouseEvent;
	
	import morn.core.components.Image;

	public class Role extends Avatar
	{
		public function Role(data:AvaterData)//$path:String, isDirRes:Boolean=false, dir:int=-1, act:String=null)
		{
			super(data);
			this.avaterType = data.type;
			this.mouseEnabled = true;
			downLayer.mouseEnabled = false;
			bodyLayer.mouseEnabled = false;
			upLayer.mouseEnabled = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			drawBg(getColor());
		}
		
		
		private var _avaterType:int = EffectPlayOwnerType.None;
		
		public function set avaterType(value:int):void
		{
			_avaterType = value;
			_data.type = value;
			drawBg(getColor());
		}
		public function get avaterType():int
		{
			return _avaterType;
		}
		
		public function getColor():int
		{
			if(_avaterType == EffectPlayOwnerType.Sender)return 0x00FF00;
			else if(_avaterType == EffectPlayOwnerType.Target)return 0xFF0000;
			else  return 0xFFFFFF;
		}
		
		private var _bodyMouseEnable:Boolean = true;
		public function set bodyMouseEnable(value:Boolean):void
		{
			_bodyMouseEnable = value;
			this.mouseEnabled = bodyLayer.mouseChildren =  bodyLayer.mouseEnabled= _bodyMouseEnable;
		}
		public function get bodyMouseEnable():Boolean
		{
			return _bodyMouseEnable;
		}
		
		
		private function handleMouseDown(e:MouseEvent):void
		{
			if(e.target is Avatar || e.target is EffectImage)//这个不管， 在centerview中会处理的
			{
				
			}else if(_bodyMouseEnable){
				e.stopImmediatePropagation();
				SimpleEvent.send(AppEvent.CLICK_ROLE, {role:this, stageX:e.stageX, stageY:e.stageY});
			}
		}
	}
}