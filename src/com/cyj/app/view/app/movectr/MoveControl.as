package com.cyj.app.view.app.movectr
{
	import com.cyj.app.utils.ComUtill;
	import com.cyj.app.view.unit.Role;
	
	import flash.display.Sprite;
	
	public class MoveControl extends Sprite
	{
		private var _fromCell:MoveControlCell;
		private var _toCell:MoveControlCell;
		private var _line:MoveControlLine;
		private var _distance:int;
		
		public function MoveControl()
		{
			super();
			_fromCell = new MoveControlCell(this);
			_toCell = new MoveControlCell(this);
			this.addChild(_fromCell);
			this.addChild(_toCell);
			this._fromCell.mouseEnabled = this._fromCell.mouseChildren = false;
		}
		
		public function bind(from:Role, end:Role, distance:int):void
		{
			this._fromCell.target = from;	
			this._toCell.target = end;
			this._distance = distance;
			update();
		}
		
		public function get fromCell():MoveControlCell
		{
			return _fromCell;
		}
		public function get toCell():MoveControlCell
		{
			return _toCell;
		}
		
		public function set distance(value:int):void
		{
			_distance = value;
			update();
		}
		
		public function get distance():int
		{
			var targetDis:int = ComUtill.getDistance(fromCell.target, toCell.target);
			var cellDis:int = ComUtill.getDistance(fromCell, toCell);
			return cellDis-targetDis;
//			return _distance;
		}
		
		
		public function update():void
		{
			this._fromCell.x = _fromCell.target.x;
			this._fromCell.y = _fromCell.target.y;
			var angle:Number = Math.atan2(-fromCell.target.y+toCell.target.y, -fromCell.target.x+toCell.target.x);
			if(_distance)
			{
				this._toCell.x = _fromCell.target.x + (_distance)*Math.cos(angle);//_toCell.target.x;
				this._toCell.y = _fromCell.target.y + (_distance)*Math.sin(angle);//_toCell.target.x;
			}else{
				this._toCell.x = toCell.target.x + (_distance)*Math.cos(angle);//_toCell.target.x;
				this._toCell.y = toCell.target.y + (_distance)*Math.sin(angle);//_toCell.target.x;
			}
			updateLine();
		}
		
		public function updateLine():void
		{
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xff0000);
			this.graphics.moveTo(_fromCell.x, _fromCell.y);
			this.graphics.lineTo(_toCell.x, _toCell.y);
			this.graphics.endFill();
		}
		
		
		public function dispose():void
		{
			if(this.parent)
				this.parent.removeChild(this);
		}
	}
}