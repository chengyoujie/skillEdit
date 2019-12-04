/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.app {
	import morn.core.components.*;
	import com.cyj.app.view.app.EffectItem;
	import com.cyj.app.view.app.FileItem;
	public class LeftViewUI extends View {
		public var treeEffect:Tree = null;
		public var listEffect:List = null;
		public var treeRole:Tree = null;
		public var btnAddEff:Button = null;
		public var btnRemoveEff:Button = null;
		protected static var uiView:XML =
			<View width="197" height="800">
			  <Label text="特效组列表" x="39" y="584" width="99" height="18" color="0x990000" align="center"/>
			  <Tree x="19" y="268" width="162" height="302" scrollBarSkin="png.comp.vscroll" spaceBottom="3" var="treeEffect">
			    <FileItem name="render" runtime="com.cyj.app.view.app.FileItem" x="10" y="10"/>
			  </Tree>
			  <List x="35" y="606" vScrollBarSkin="png.comp.vscroll" width="146" height="188" spaceY="2" var="listEffect">
			    <EffectItem name="render" runtime="com.cyj.app.view.app.EffectItem"/>
			  </List>
			  <Label text="特效资源列表" x="52.5" y="245" width="99" height="18" color="0x990000" align="center"/>
			  <Label text="角色资源列表" x="52.5" y="11" width="99" height="18" color="0x990000" align="center"/>
			  <Tree x="19" y="32" width="162" height="195" scrollBarSkin="png.comp.vscroll" spaceBottom="3" var="treeRole">
			    <FileItem name="render" runtime="com.cyj.app.view.app.FileItem" x="10" y="10"/>
			  </Tree>
			  <Button skin="png.guidecomp.btn_加号_1" x="134" y="585" var="btnAddEff"/>
			  <Button skin="png.guidecomp.btn_减号_1" x="157" y="585" var="btnRemoveEff"/>
			</View>;
		public function LeftViewUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.app.EffectItem"] = EffectItem;
			viewClassMap["com.cyj.app.view.app.FileItem"] = FileItem;
			super.createChildren();
			createView(uiView);
		}
	}
}