package com.cyj.app.data.cost
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Quint;
	import com.greensock.easing.Sine;

	public class EaseType
	{
		public function EaseType()
		{
		}
		public static const line:int = 0;
		public static const quadIn:int = 1;
		public static const quadOut:int = 2;
		public static const quadInOut:int = 3;
		public static const cubicIn:int = 4;
		public static const cubicOut:int = 5;
		public static const cubicInOut:int = 6;
		public static const quartIn:int = 7;
		public static const quartOut:int = 8;
		public static const quartInOut:int = 9;
		public static const quintIn:int = 10;
		public static const quintOut:int = 11;
		public static const quintInOut:int = 12;
		public static const sineIn:int = 13;
		public static const sineOut:int = 14;
		public static const sineInOut:int = 15;
		public static const backIn:int = 16;
		public static const backOut:int = 17;
		public static const backInOut:int = 18;
		public static const circIn:int = 19;
		public static const circOut:int = 20;
		public static const circInOut:int = 21;
		public static const bounceIn:int = 22;
		public static const bounceOut:int = 23;
		public static const bounceInOut:int = 24;
		public static const elasticIn:int = 25;
		public static const elasticOut:int = 26;
		public static const elasticInOut:int = 27;
		
		public static function getEase(type:int):Function
		{
			switch(type)
			{
				case  EaseType.line:return null;//默认的
				case  EaseType.quadIn:return  Quad.easeIn;
				case  EaseType.quadOut:return Quad.easeOut;
				case  EaseType.quadInOut:return Quad.easeInOut;
				case  EaseType.cubicIn:return Cubic.easeIn;
				case  EaseType.cubicOut:return Cubic.easeOut;
				case  EaseType.cubicInOut:return Cubic.easeInOut;
				case  EaseType.quartIn:return Quart.easeIn;
				case  EaseType.quartOut:return Quart.easeOut;
				case  EaseType.quartInOut:return Quart.easeInOut;
				case  EaseType.quintIn:return Quint.easeIn;
				case  EaseType.quintOut:return Quint.easeOut;
				case  EaseType.quintInOut:return Quint.easeInOut;
				case  EaseType.sineIn:return Sine.easeIn;
				case  EaseType.sineOut:return Sine.easeOut;
				case  EaseType.sineInOut:return Sine.easeInOut;
				case  EaseType.backIn:return Back.easeIn;
				case  EaseType.backOut:return Back.easeOut;
				case  EaseType.backInOut:return Back.easeInOut;
				case  EaseType.circIn:return Circ.easeIn;
				case  EaseType.circOut:return Circ.easeOut;
				case  EaseType.circInOut:return Circ.easeInOut;
				case  EaseType.bounceIn:return Bounce.easeIn;
				case  EaseType.bounceOut:return Bounce.easeOut;
				case  EaseType.bounceInOut:return Bounce.easeInOut;
				case  EaseType.elasticIn:return Elastic.easeIn;
				case  EaseType.elasticOut:return Elastic.easeOut;
				case  EaseType.elasticInOut:return Elastic.easeInOut;
				
			}
			return null;
		}
	}
}