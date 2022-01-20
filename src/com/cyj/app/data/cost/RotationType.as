package com.cyj.app.data.cost
{
	public class RotationType
	{
		//自定义,拥有者方向,目标方向,目标中的一个,从施法者到目标,从目标到施法者
		public static const COSTOM:int = 0;
		public static const OWNER:int = 1;
		public static const TARGET:int = 2;
		public static const ONE_TARGET:int = 3;
		
		public static const SEND_TO_TARGET:int = 4;
		
		public static const TARGET_TO_SEND:int = 5;
		
		public function RotationType()
		{
		}
	}
}