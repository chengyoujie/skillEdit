package com.cyj.app.view.app
{
	import com.cyj.app.view.ui.app.EffectItemUI;
	import com.cyj.app.view.unit.SubImageInfo;
	
	public class EffectItem extends EffectItemUI
	{
		public function EffectItem()
		{
			super();
			this.mouseChildren = false;
		}
		
		override public function set dataSource(value:Object):void
		{
			if(value)
				txtName.text = value.id;
			else
				txtName.text = "";
			super.dataSource = value;
		}
	}
}