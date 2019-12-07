package com.cyj.app.data.cost
{
	public class EffectPlayEndType
	{
		/**特效播放结束 endParam 为播放次数*/
		public static const EffectPlayComplete:int = 0;
		/**特效达到某一位置 endParam EffectPlayPosEndData*/
		public static const MoveEnd:int = 1;
		/**特效播放多长时间 endParam 时间ms */
		public static const Time:int = 2;
		/**使用插件作为结束 */
		public static const Plug:int = 3;
		
		public function EffectPlayEndType()
		{
		}
	}
}