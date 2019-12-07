package com.cyj.app.view.app
{
	import com.cyj.app.data.EffectGroupItemData;
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
			if(value is EffectGroupItemData)
			{
				var d:EffectGroupItemData = value as EffectGroupItemData;
				txtId.text =  d.id+"";
				txtName.text =  d.name;
			}
			else{
				txtName.text = "";
				txtId.text = "";
			}
			super.dataSource = value;
		}
	}
}