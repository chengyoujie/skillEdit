package com.cyj.app.view.app.movectr
{
	import com.cyj.app.view.unit.Role;
	
	import flash.display.Sprite;
	
	public class MoveControlCell extends Sprite
	{
		private var _ctr:MoveControl;
		public var target:Role;
		
		public function MoveControlCell(ctr:MoveControl)
		{
			super();
			_ctr = ctr;
			drawBg(0x0724ff);
		}
		
		public function get control():MoveControl
		{
			return _ctr;
		}
		
		
		protected function drawBg(color:int):void
		{
			var hw:int = 12;
			this.graphics.clear();
			this.graphics.beginFill(color, 0.4);
			this.graphics.drawCircle(0, 0, hw);
			this.graphics.endFill();
		}
		
	}
}