/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.FileItem;
	import com.cyj.app.view.app.ImageResItem;
	public class LeftViewUI extends View {
		public var treeFiles:Tree = null;
		public var listImageRes:List = null;
		protected static var uiView:XML =
			<View width="197" height="732">
			  <Label text="技能列表" x="54" y="17" width="99" height="18" color="0x990000"/>
			  <Tree x="17" y="51" width="162" height="368" scrollBarSkin="png.comp.vscroll" spaceBottom="3" var="treeFiles">
			    <FileItem name="render" runtime="com.cyj.app.view.app.FileItem" x="10" y="10"/>
			  </Tree>
			  <List x="34" y="444" vScrollBarSkin="png.comp.vscroll" width="146" height="267" spaceY="2" var="listImageRes">
			    <ImageResItem name="render" runtime="com.cyj.app.view.app.ImageResItem"/>
			  </List>
			</View>;
		public function LeftViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.FileItem"] = FileItem;
			viewClassMap["com.cyj.app.view.app.ImageResItem"] = ImageResItem;
			super.createChildren();
			createView(uiView);
		}
	}
}