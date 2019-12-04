package com.cyj.app.view.app
{
	import com.cyj.app.data.effect.EffectPlayItemData;
	import com.cyj.app.view.ui.app.EffectStepItemUI;
	
	public class EffectStepItem extends EffectStepItemUI
	{
		private var _data:EffectPlayItemData;
		public function EffectStepItem()
		{
			super();
		}
		
		public function refush():void
		{
			if(_data)
				this.dataSource = _data;
		}
		
		override public function set dataSource(value:Object):void
		{
			if(value)
			{
				_data = value as EffectPlayItemData;
				txtName.text = value.id;
			}
			super.dataSource = value;
		}
	}
}