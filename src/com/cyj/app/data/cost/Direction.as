package com.cyj.app.data.cost
{
	import flash.display.DisplayObject;

	public class Direction
	{
		
		/** 向上 */
		public static const TOP:int = 0;	
		/** 朝右上 */
		public static const RIGHTTOP:int = 1;	
		/** 朝右 */
		public static const RIGHT:int = 2;			
		/** 朝右下 */
		public static const RIGHTBOTTOM:int = 3;
		/** 向下 */
		public static const BOTTOM:int = 4;			
		/** 朝左下 */
		public static const LEFTBOTTOM:int = 5;
		/** 朝左 */
		public static const LEFT:int = 6;			
		/** 朝左上 */
		public static const LEFTTOP:int = 7;		
		
		/**绑定者的方向**/
		public static const OWNER_DIR:int = 8;
		
		/**受击者方向**/
		public static const TO_TARGET_DIR:int = 9;
		
		public static function getDirName(dir:int):String
		{
			//↑上,↗右上,→右,↘右下,↓下,↙左下,←左,↖左上,绑定者方向,受击者方向
			switch(dir){
				case Direction.TOP:return "↑上";
				case Direction.RIGHTTOP:return "↗右上";
				case Direction.RIGHT:return "→右";
				case Direction.RIGHTBOTTOM:return "↘右下";
				case Direction.BOTTOM:return "↓下";
				case Direction.LEFTBOTTOM:return "↙左下";
				case Direction.LEFT:return "←左";
				case Direction.LEFTTOP:return "↖左上";
				case Direction.OWNER_DIR:return "绑定者方向";
				case Direction.TO_TARGET_DIR:return "受击者方向";
			}
			return "None";
		}
		
		public static function getHaveResDir(dir:int):int
		{
			if(dir == Direction.LEFT)
			{
				return Direction.RIGHT;
			}else if(dir == Direction.LEFTTOP)
			{
				return Direction.RIGHTTOP;
			}else if(dir == Direction.LEFTBOTTOM)
			{
				return Direction.RIGHTBOTTOM;
			}
			return dir;
		}
		
		/**
		 * 根据方向将目标节点修改为该方向,且返回五方向中对应的方向
		 * @param dir方向
		 * @param display?要修改的节点
		 */
		public static function getFiveDir(dir:int, display: DisplayObject=null): int {
			var newDire: int = dir;
			var scaleX: int = 1;
			switch (dir) {
				case Direction.LEFTTOP:
					newDire = Direction.RIGHTTOP;
					scaleX = -1;
					break;
				case Direction.LEFT:
					newDire = Direction.RIGHT;
					scaleX = -1;
					break;
				case Direction.LEFTBOTTOM:
					newDire = Direction.RIGHTBOTTOM;
					scaleX = -1;
					break;
			}
			if (display) {
				display.scaleX = scaleX;
			}
			return newDire;
		}
		
		/**
		 * 五方向反过来， 根据有资源的方向获取没有资源的方向 
		 */
		public static function getReverseFiveDir(dir:int): int {
			var newDire: int = dir;
			switch (dir) {
				case Direction.RIGHTTOP:
					newDire = Direction.LEFTTOP;
					break;
				case Direction.RIGHT:
					newDire = Direction.LEFT;
					break;
				case Direction.RIGHTBOTTOM:
					newDire = Direction.LEFTBOTTOM;
					break;
			}
			return newDire;
		}
		
		/**
		 * 根据起始点和目标点，获取起始点相对于目标点方向
		 * @param startP起始坐标
		 * @param targetP目标坐标
		 */
		public static function getDir(startP: *, targetP: *): int {
			var dir: int = Direction.TOP;
			if(!startP || !targetP)return dir; 
			var decX: Number = targetP.x - startP.x;
			var decY: Number = targetP.y - startP.y;
			var angle: Number = Math.atan2(decY, decX) * 180 / Math.PI;
			if (angle >= -20 && angle < 20) {
				dir = Direction.RIGHT;
			}
			else if (angle >= 20 && angle < 70) {
				dir = Direction.RIGHTBOTTOM; //3;
			}
			else if (angle >= 70 && angle < 110) {
				dir = Direction.BOTTOM;//4;
			}
			else if (angle >= 110 && angle < 160) {
				dir = Direction.LEFTBOTTOM;
			}
			else if (angle >= 160 || angle < -160) {
				dir = Direction.LEFT;
			}
			else if (angle >= -70 && angle < -20) {
				dir = Direction.RIGHTTOP;//1;
			}
			else if (angle >= -110 && angle < -70) {
				dir = Direction.TOP;
			}
			else if (angle >= -160 && angle < -110) {
				dir = Direction.LEFTTOP;
			}
			return dir;
		}
		
		/**
		 * 根据方向获取角度值 
		 * @param dir 方向
		 * */
		public static function getDegrees(dir: int): Number {
			switch (dir) {
				case Direction.TOP:
					return 270;
				case Direction.RIGHTTOP:
					return 315;
				case Direction.RIGHT:
					return 0;
				case Direction.RIGHTBOTTOM:
					return 45;
				case Direction.BOTTOM:
					return 90;
				case Direction.LEFTBOTTOM:
					return 135;
				case Direction.LEFT:
					return 180;
				case Direction.LEFTTOP:
					return 225;
			}
			return 0;
		}
		
		public function Direction()
		{
		}
	}
}