package com.cyj.app.data.effect
{
	import com.cyj.app.data.ICopyData;
	import com.cyj.app.data.cost.EffectPlayDisplayType;
	import com.cyj.app.data.cost.EffectPlayLayer;
	import com.cyj.app.data.cost.EffectPlayOwnerType;

	public class EffectPlayItemData implements ICopyData
	{
		public var id:int;
		
		public var name:String;
		/**特效资源名字 */
		public var disInfo:EffectPlayDisplayInfo = new EffectPlayDisplayInfo();
		/**特效所有者 可以为空 */
		public var effOwnerType:int = EffectPlayOwnerType.Sender;
		/**特效所在的层级 */
		public var layer:int = EffectPlayLayer.Top;
		/**结束条件 */
		public var endType:int;
		/**结束参数 */
		public var endParam:* = 0;
		/**开始条件 */
		public var tiggler:int;
		/**开始参数 */
		public var tigglerParam:*=0;
		/**移动参数 如果设置为move 则图层不能选择在角色身上（要不）*/
		public var move:EffectPlayMoveEndData = new EffectPlayMoveEndData();
		/**偏移X */
		public var offx:int;
		/**偏移Y */
		public var offy:int;
		
		public var scalex:Number = 1;
		public var scaley:Number = 1;
		/**延迟执行时间 */
		public var delay:int;
		/**是否延迟时间随机**/
		public var delayRandom:int;
		/**旋转类型**/
		public var rotationType:int = 0;
		/**旋转角度**/
		public var rotation:Number = 0;
		/**缓动的参数**/
		public var tweenProps:Array = [];
		/**是否使用屏幕中心坐标*/	
		public var useScreen:Boolean = false;
		/**是否绑定拥有者**/
		public var bindOwner:Boolean = false;
		
		public function EffectPlayItemData()
		{
		}
		
		public function parser(data:Object):void
		{
			for(var key:String in data)
			{
				if(key == "move")
				{
//					var moveItem:EffectPlayMoveEndData = new EffectPlayMoveEndData();
					move.parser(data[key]);
					this[key] = move;
				}else if(key == "disInfo")
				{
//					var disInfoItem:EffectPlayDisplayInfo = new EffectPlayDisplayInfo();
					disInfo.parser(data[key]);
					this[key] = disInfo;
				}else if(key == "tweenProps")
				{
					var tweens:Array = [];
					for(var i:int=0; i<data["tweenProps"].length; i++)
					{
						var item:EffectPlayTweenData = new EffectPlayTweenData();
						item.parser(data["tweenProps"][i]);
						tweens.push(item);
					}
					this.tweenProps = tweens;
				}
				else if(this.hasOwnProperty(key))
				{
					this[key] = data[key];
				}
			}
		}
		
		public function copy():ICopyData
		{
			var cd:EffectPlayItemData = new EffectPlayItemData();
			cd.parser(JSON.parse(JSON.stringify(this)));
			return cd;
		}
	}
}