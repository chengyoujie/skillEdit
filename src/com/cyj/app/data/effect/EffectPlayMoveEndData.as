package com.cyj.app.data.effect
{
	public class EffectPlayMoveEndData
	{
		
		/**目标位置类型 */
		public var type:int;
		/**移动速度 与time二选一  优先time*/
		public var speed:int = 500;
		/**距离的类型**/
		public var distanceType:int = 0;
		// angle
		public var distance:int;
		/**偏移X的类型  **/
		public var offXType:int = 0;
		/**偏移X */
		public var offx:String = "0";
		/**偏移Y的类型  **/
		public var offYType:int = 0;
		/**偏移Y */
		public var offy:String = "0";
		
		/**移动类型**/
		public var ease:int;
		/**旋转角度**/
		public var rotation:int = 0;
		/**旋转角度类型**/
		public var rotationType:int = 0;
//		/**是否自动设置旋转方向 */
//		public var rotation:Boolean = false;
		
		public function EffectPlayMoveEndData()
		{
		}
		
		public function parser(data:Object):void
		{
			for(var key:String in data)
			{
				if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
	}
}