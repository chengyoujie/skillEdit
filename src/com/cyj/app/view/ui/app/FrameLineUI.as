/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.common.frame.FrameItem;
	public class FrameLineUI extends View {
		public var btnHide:Button = null;
		public var btnLock:Button = null;
		public var listFrame:List = null;
		public var imgBg:Image = null;
		protected static var uiView:XML =
			<View width="600" height="35">
			  <Button label="隐" skin="png.comp.button" x="5" y="6" width="20" height="23" var="btnHide"/>
			  <Button label="锁" skin="png.comp.button" x="29" y="6" width="20" height="23" var="btnLock"/>
			  <List x="54" y="2" repeatY="1" repeatX="45" var="listFrame" spaceX="1">
			    <Image skin="png.comp.blank" width="544" height="28" y="1" var="imgBg"/>
			    <FrameItem x="1" name="render" runtime="com.cyj.app.view.common.frame.FrameItem"/>
			  </List>
			</View>;
		public function FrameLineUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.common.frame.FrameItem"] = FrameItem;
			super.createChildren();
			createView(uiView);
		}
	}
}