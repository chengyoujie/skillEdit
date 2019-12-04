package com.cyj.app.view.common
{
	import com.cyj.app.view.ui.common.TipMsgUI;
	import com.cyj.utils.Log;
	import com.greensock.TweenLite;
	
	public class TipMsg extends TipMsgUI
	{
		public function TipMsg()
		{
			super();
		}
		
		public static function show(value:String):void
		{
			var tip:TipMsg = new TipMsg();
			tip.txtMsg.text = value;
			Log.log(value);
			tip.txtMsg.width = tip.txtMsg.textField.textWidth+20;
			tip.imgBg.width = tip.txtMsg.width;
			App.stage.addChild(tip);
			tip.x = App.stage.stageWidth/2 - tip.txtMsg.width/2;
			tip.y = App.stage.stageHeight - 150;
			var toy:int =  App.stage.stageHeight - 300;
			TweenLite.to(tip, 0.5, {y:toy,onComplete:tip.removeTip});//, onCompleteParams:[tip]});
		}
		
		public function removeTip():void
		{
			App.timer.doOnce(2000, dispose); 
		} 
		
		override public function dispose():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);	
			}
			super.dispose();
		}
	}
}