package com.cyj.app.view.common.edit
{
	import flash.display.Sprite;
	
	public class EditBlock extends Sprite
	{
		public var pos:int = 0;
		public function EditBlock()
		{
			super();
			this.graphics.clear();
			this.graphics.beginFill(0xffffff, 0.8);
			this.graphics.lineStyle(1, 0xff0000);
			this.graphics.drawRect(-3,-3, 6, 6);
			this.graphics.endFill();
		}
	}
}