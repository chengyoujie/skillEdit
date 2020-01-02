package com.cyj.app.view.app
{
	import com.cyj.app.data.effect.EffectPlayTweenItemData;
	import com.cyj.app.utils.BindData;
	import com.cyj.app.view.ui.app.SetTweenPropItemUI;
	
	public class SetTweenPropItem extends SetTweenPropItemUI
	{
		private var _itemBindPropData:Vector.<BindData>;
		private var _data:EffectPlayTweenItemData;
		
		public function SetTweenPropItem()
		{
			super();
		}
		override protected function initialize():void
		{
			super.initialize();
		
			_itemBindPropData = new Vector.<BindData>();
			_itemBindPropData.splice(0, 0,			
				new BindData(comProp, "prop", "selectedIndex", null, null, setPropData, getPropData),
				new BindData(inputFrom, "from"),
				new BindData(inputTo, "to" )
			);
			comProp.dataSource = SetTweenView.allKeys;
		}
		
		private function setPropData(index:int):String
		{
			var d:Object = SetTweenView.tweenIndex2Data[index];
			if(d)
				return d.prop;
			return "";
		}
		
		private function getPropData(str:String):int{
			var d:Object = SetTweenView.tweenData[str];
			if(d)
				return d.index;
			return -1;
		}
		
		private function toBind(binds:Vector.<BindData>, data:Object):void
		{
			for(var i:int=0; i<binds.length; i++)
			{
				binds[i].bind(data);
			}
		}
		
		private var _index:int=0;
		public function set $_index(value:int):void
		{
			_index = value;
			txtIndex.text = ""+_index;
		}
		public function get $_index():int
		{
			return _index;
		}
		
		override public function set dataSource(value:Object):void
		{
			_data = value as EffectPlayTweenItemData;
			toBind(_itemBindPropData, _data); 
		}
	
	}
}