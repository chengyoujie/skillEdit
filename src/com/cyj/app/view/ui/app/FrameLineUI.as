/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.common.frame.FrameItem;
	public class FrameLineUI extends View {
		public var btnHide:Button = null;
		public var btnLock:Button = null;
		public var listFrame:List = null;
		public var imgBg:Image = null;
		public var txtName:Label = null;
		protected static var uiView:XML =
			<View width="880" height="35">
			  <Clip skin="png.comp.clip_selectBox" x="1" y="8" clipY="2" width="121" name="selectBox" height="20"/>
			  <Button label="隐" skin="png.comp.button" x="76" y="5" width="20" height="23" var="btnHide"/>
			  <Button label="锁" skin="png.comp.button" x="100" y="5" width="20" height="23" var="btnLock"/>
			  <List x="125" y="3" repeatY="1" repeatX="60" var="listFrame" spaceX="1">
			    <Image skin="png.comp.blank" width="756" height="28" y="1" var="imgBg" x="0"/>
			    <FrameItem x="1" name="render" runtime="com.cyj.app.view.common.frame.FrameItem"/>
			  </List>
			  <Label text="图层名字" x="23" y="7" color="0xffff00" var="txtName"/>
			  <Clip skin="png.comp.clip_tree_folder" x="3" y="10" clipY="3"/>
			</View>;
		public function FrameLineUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.common.frame.FrameItem"] = FrameItem;
			super.createChildren();
			createView(uiView);
		}
	}
}