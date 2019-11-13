/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.FileItem;
	public class LeftViewUI extends View {
		public var treeFiles:Tree = null;
		protected static var uiView:XML =
			<View width="197" height="732">
			  <Label text="技能列表" x="54" y="17" width="99" height="18" color="0x990000"/>
			  <Tree x="17" y="51" width="162" height="368" scrollBarSkin="png.comp.vscroll" spaceBottom="3" var="treeFiles">
			    <FileItem name="render" runtime="com.cyj.app.view.app.FileItem" x="10" y="10"/>
			  </Tree>
			</View>;
		public function LeftViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.FileItem"] = FileItem;
			super.createChildren();
			createView(uiView);
		}
	}
}