package com.cyj.app.data.effect
{
	public class EffectPlayDisplayInfo
	{
		/**显示对象的类型 */
		public var type:int;
		/**显示对应的数据  如Mc为资源id, Image为图片 */
		public var data:*;
		/**循环次数默认为1， 只适用于Movie类型 */
		public var loop:int = 1;
		/**MC方向  如果不填则直接读取， 如果填了则使用有方向的资源 */
		public var dir:int;
		
		public function EffectPlayDisplayInfo()
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