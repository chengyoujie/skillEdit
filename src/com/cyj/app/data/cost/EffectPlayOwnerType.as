package com.cyj.app.data.cost
{
	public class EffectPlayOwnerType
	{
		public static const None:int = 0;
			
		public static const Sender:int = 1;
			
		public static const Target:int = 2;
		
		/**其中的一个目标 */
		public static const OneTarget:int = 3;
		/**我方全体**/
		public  static const  MyTeam:int = 4;
		/**圣物**/
		public static const ShengWu:int = 5;
		/**主人**/
		public static const Master:int = 6;
		
		
		
		public function EffectPlayOwnerType()
		{
		}
	}
}