package com.cyj.app.data.cost
{
	public class EffectPlayLayer
	{
		/**角色顶部 */
		public static const RoleTop:int = 0;
		/**角色底部 */
		public static const RoleBottom:int = 1;
		/**地图上层 */
		public static const MapTop:int = 2;
		/**地图下层 */
		public static const MapBottom:int = 3;
		/**根据方向改变层级 */
		public static const FiveDir:int = 4;
		
		/**上层跟随角色**/
		public static const FllowTop:int = 5;
		
		
		/**下层跟随角色**/
		public static const FllowBottom:int = 6;
		/**根据方向改变层级  与五方向相反 */
		public static const Reverse_FiveDir:int = 7;
		
		
		public function EffectPlayLayer()
		{
		}
	}
}