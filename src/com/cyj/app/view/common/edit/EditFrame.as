package com.cyj.app.view.common.edit
{
	import com.cyj.app.view.common.Align;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class EditFrame extends Sprite
	{
		private var _editBlocks:Array = [];
		private var _w:Number;
		private var _h:Number;
		public static const POS_ARR:Array =[
			{x:0, y:0, pos:Align.TOP|Align.LEFT}, 	{x:0.5, y:0, pos:Align.TOP|Align.CENTER}, 	{x:1, y:0, pos:Align.TOP|Align.RIGHT}, 
			{x:0, y:0.5, pos:Align.CENTER|Align.LEFT}, 																{x:1, y:0.5, pos:Align.CENTER|Align.RIGHT}, 
			{x:0, y:1, pos:Align.BOTTOM|Align.LEFT}, 	{x:0.5, y:1, pos:Align.BOTTOM|Align.CENTER}, 	{x:1, y:1, pos:Align.BOTTOM|Align.RIGHT}
		];
		public function EditFrame()
		{
			super();
			for(var i:int=0; i<POS_ARR.length; i++)
			{
				var block:EditBlock = new EditBlock();
				this.addChild(block);
				block.visible = false;
				_editBlocks.push(block);
			}
		}
		
		private function handleBlockMove(e:MouseEvent):void
		{
			var block:EditBlock = e.currentTarget as EditBlock;			
		}
		
		public function get editBlocks():Array
		{
			return _editBlocks;
		}
		
		override public function get width():Number
		{
			return _w;
		}
		override public function get height():Number
		{
			return _h;
		}
		
		public function setSize(w:Number, h:Number):void
		{
			_w = w;
			_h = h;
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xff0000, 0.8);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			for(var i:int=0; i<_editBlocks.length; i++)
			{
				var block:EditBlock = _editBlocks[i];
				block.x = POS_ARR[i].x*w;
				block.y = POS_ARR[i].y*h;
				block.pos = POS_ARR[i].pos;
				block.visible= true;
			}
		}
		
		public function clear():void
		{
			this.graphics.clear();
			
		}
		
	}
}